//
//  GameWorld.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SwiftUI

class GameWorld {
    
    // MARK: Model objects / properties
    var level: GameWorldLevel
    
    var currentlyMovingBlock: Block?
    
    var highestPoint: CGFloat {
        level.getHighestPoint(excluding: currentlyMovingBlock)
    }
    
    /// Obtains the leftmost and rightmost points of the CMB.
    var referencePoints: (left: CGPoint, right: CGPoint)? {
        guard let block = currentlyMovingBlock else { return nil }
        let width = block.width
        let xPosLeft: Double = block.position.x - width / 2
        let xPosRight: Double = block.position.x + width / 2
        let yPos: Double = 0
        return (left: CGPoint(x: xPosLeft, y: yPos),
                right: CGPoint(x: xPosRight, y: yPos))
    }

    private var dimensions: CGRect {
        level.dimensions
    }

    
    // MARK: Engines & Managers
    var fiziksEngine: FiziksEngine
    
    var eventManager: EventManager {
        didSet {
            powerupManager?.eventManager = eventManager
        }
    }
    
    var powerupManager: PowerupManager?
    

    // MARK: Generators
    private var rng: RandomNumberGeneratorWithSeed

    private var shapeRandomizer: ShapeRandomizer
    
    private var isGameEnded: Bool = false

    
    // MARK: Initializer
    init(levelDimensions: CGRect, seed: Int = GameWorldConstants.defaultSeed, eventManager: EventManager) {
        self.eventManager = eventManager
        self.level = GameWorldLevel(levelDimensions: levelDimensions)
        self.fiziksEngine = GameFiziksEngine(size: levelDimensions)
        self.shapeRandomizer = ShapeRandomizer(possibleShapes: TetrisType.allCases, seed: seed)
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
        self.powerupManager = GamePowerupManager(eventManager: eventManager, gameWorld: self, seed: seed)
        
        setUpFiziksEngine()
    }

    func startGame() {
        isGameEnded = false
        setUpLevel()
        insertNewBlock()
    }

    func resetGame() {
        level.reset()
        // TODO: Possibly need to remove all fiziksBodies due to cycle?
        fiziksEngine.deleteAllBodies()
        
        fiziksEngine = GameFiziksEngine(size: dimensions)
        setUpFiziksEngine()
    }
    
    func endGame() {
        level.reset()
        isGameEnded = true
        // TODO: Possibly need to remove all fiziksBodies due to cycle?
        fiziksEngine.deleteAllBodies()
    }

    /// Update method called by GameEngine every frame
    func update() {
        removeOutOfBoundsObjects()
        handleBlocksInContactWithPowerupLine()
    }

    // MARK: Block methods
    func insertNewBlock() {
        if isGameEnded {
            return
        }
        
        let shape = shapeRandomizer.getShape()
        let insertedBlock = addBlock(ofShape: shape, at: level.blockInsertionPoint)
        currentlyMovingBlock = insertedBlock

        eventManager.postEvent(BlockInsertedEvent())
    }
    
    func moveCMB(by vector: CGVector) {
        guard let blockToMove = currentlyMovingBlock else {
            return
        }
        level.move(gameWorldObject: blockToMove, by: vector)
    }
    
    func rotateCMB(by rotation: Double) {
        guard let blockToMove = currentlyMovingBlock else {
            return
        }
        level.rotate(gameWorldObject: blockToMove, by: rotation)
    }
    
    @discardableResult
    private func addBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        guard let newBlock: Block = GameWorldObjectFactory.create(ofType: .block,
                                                                               ofShape: shape,
                                                                               at: position) else {
            // TODO: throw error
            assert(false)
        }
        
        addObject(object: newBlock)
        
        // make block move at constant speed
        newBlock.fiziksBody.affectedByGravity = false
        newBlock.fiziksBody.velocity = .zero
        newBlock.fiziksBody.applyImpulse(GameWorldConstants.defaultBlockVelocity)
        
        // prevent newly inserted blocks from rotating via collisions
        newBlock.fiziksBody.allowsRotation = false
        
        return newBlock
    }
    
    // MARK: Level setup methods
    private func setUpLevel() {
        // Set main platform
        setLevelPlatform()
        setLevelBoundaries()
        setPowerupLine()
    }

    private func setLevelPlatform() {
        let platformPosition = CGPoint(x: Int(dimensions.width) / 2, y: GameWorldConstants.mainPlatformYPos)
        let path = CGPath.create(from: GameWorldConstants.mainPlatformPoints)
        let platformShape = GamePathObjectShape(path: path)
        guard let platform: Platform = GameWorldObjectFactory.create(ofType: .platform,
                                                                     ofShape: platformShape,
                                                                     at: platformPosition) else {
            assert(false)
            return
        }
        level.setMainPlatform(platform: platform)
        
        fiziksEngine.add(platform.fiziksBody)
    }
    
    private func setLevelBoundaries() {
        // left boundary
        let leftPosition = CGPoint(x: dimensions.midX - GameWorldConstants.defaultPlatformBoundaryBuffer, y: dimensions.midY)
        let leftBoundary = createLevelBoundary(at: leftPosition)
        level.leftBoundary = leftBoundary
        fiziksEngine.add(leftBoundary.fiziksBody)
        
        // right boundary
        let rightPosition = CGPoint(x: dimensions.midX + GameWorldConstants.defaultPlatformBoundaryBuffer, y: dimensions.midY)
        let rightBoundary = createLevelBoundary(at: rightPosition)
        level.rightBoundary = rightBoundary
        fiziksEngine.add(rightBoundary.fiziksBody)
    }
    
    private func setPowerupLine() {
        let pos = CGPoint(x: dimensions.midX, y: GameWorldConstants.defaultInitialPowerupHeight)
        let rect = CGRect(x: pos.x,
                          y: pos.y,
                          width: GameWorldConstants.defaultPowerupLineDimensions.width,
                          height: GameWorldConstants.defaultPowerupLineDimensions.height)
        level.powerupLine = PowerupLine(position: pos, dimensions: rect)
    }
    
    private func setUpFiziksEngine() {
        let fiziksEngineBoundingRect = CGRect(x: dimensions.minX,
                                              y: dimensions.minY - 100,
                                              width: dimensions.width,
                                              height: dimensions.height + 200)
        fiziksEngine.insertBounds(fiziksEngineBoundingRect)
        fiziksEngine.fiziksContactDelegate = self
    }
    
    // MARK: Other methods
    func pauseGame() {
        fiziksEngine.pause()
    }
    
    func unpauseGame() {
        fiziksEngine.unpause()
    }
    
    func addObject(object: GameWorldObject) {
        level.add(gameWorldObject: object)
        fiziksEngine.add(object.fiziksBody)
    }
    
    func removeObject(object: GameWorldObject) {
        level.remove(gameWorldObject: object)
        fiziksEngine.delete(object.fiziksBody)
        if object === currentlyMovingBlock {
            insertNewBlock()
        }
    }
    
    private func createLevelBoundary(ofWidth width: CGFloat = GameWorldConstants.levelBoundaryWidth,
                                     at position: CGPoint) -> LevelBoundary {
        let rect = CGRect(origin: position, size: CGSize(width: width, height: dimensions.height))
        let path = CGPath.create(from: rect, centered: true)
        let shape = GamePathObjectShape(path: path)
        guard let newBoundary: LevelBoundary = GameWorldObjectFactory.create(ofType: .levelBoundary,
                                                                             ofShape: shape,
                                                                             at: position) else {
            // TODO: throw error
            assert(false)
        }
        return newBoundary
    }
    
    private func removeOutOfBoundsObjects() {
        for object in level.outOfBoundsObjects {
            removeObject(object: object)
            eventManager.postEvent(BlockDroppedEvent())
        }
    }
    
    private func handleBlocksInContactWithPowerupLine() {
        guard let blocksInContact = level.blocksInContactWithPowerupLine else {
            return
        }
        if blocksInContact.count >= 1 {
            eventManager.postEvent(BlockTouchedPowerupLineEvent())
            level.updatePowerupLineHeight()
            powerupManager?.createNextPowerup()
        }
    }
}

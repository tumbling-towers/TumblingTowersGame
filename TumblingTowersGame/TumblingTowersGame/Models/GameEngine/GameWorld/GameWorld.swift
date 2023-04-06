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
    
    private var currentlyMovingBlock: Block? {
        didSet {
            if currentlyMovingBlock == nil && !isGameEnded {
                insertNewBlock()
            }
        }
    }
    
    private var dimensions: CGRect {
        level.dimensions
    }

    
    // MARK: Engines & Managers
    var fiziksEngine: FiziksEngine
    
    var eventManager: EventManager {
        didSet {
            powerupManager.eventManager = eventManager
        }
    }
    
    var powerupManager: PowerupManager
    

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
        self.powerupManager = GamePowerupManager(eventManager: eventManager, seed: seed)
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
        
        setUpFiziksEngine()
    }

    /// Obtains the leftmost and rightmost points of the CMB.
    func getReferencePoints() -> (left: CGPoint, right: CGPoint)? {
        guard let block = currentlyMovingBlock, let shape = currentlyMovingBlock?.shape as? TetrisShape else { return nil }
        let movingGameObjectBlock = GameObjectBlock(position: block.position, path: shape.path, rotation: block.rotation)
        let xPosLeft: Double = movingGameObjectBlock.position.x - movingGameObjectBlock.width / 2
        let xPosRight: Double = movingGameObjectBlock.position.x + movingGameObjectBlock.width / 2
        let yPos: Double = 0
        return (left: CGPoint(x: xPosLeft, y: yPos), right: CGPoint(x: xPosRight, y: yPos))
    }

    func startGame() {
        self.isGameEnded = false
        setUpLevel()
        insertNewBlock()
    }

    func resetGame() {
        self.level.reset()
        self.currentlyMovingBlock = nil
        // TODO: Possibly need to remove all fiziksBodies due to cycle?
        fiziksEngine.deleteAllBodies()
        
        self.fiziksEngine = GameFiziksEngine(size: dimensions)
        setUpFiziksEngine()
    }
    
    func endGame() {
        self.level.reset()
        self.isGameEnded = true
        self.currentlyMovingBlock = nil
        // TODO: Possibly need to remove all fiziksBodies due to cycle?
        fiziksEngine.deleteAllBodies()
    }

    /// Update method called by GameEngine every frame
    func update() {
        print(level.gameObjects.count)
        for object in level.gameObjects {
            if level.isOutOfBounds(object) {
                // TODO: Emit event that a block has gone out of bounds.
                removeObject(object: object)

                eventManager.postEvent(BlockDroppedEvent())

                if object === currentlyMovingBlock {
                    currentlyMovingBlock = nil
                }
            }

            if object.fiziksBody.categoryBitMask == CategoryMask.block {
                // TODO: more elegant way besides downcasting?
                guard let block = object as? Block else { continue }
                checkAndHandleContactPowerupLine(currentBlock: block)
            }
        }
    }

    // MARK: Block methods
    @discardableResult
    func insertNewBlock() -> Block {
        let shape = shapeRandomizer.getShape()
        let insertedBlock = addBlock(ofShape: shape, at: level.blockInsertionPoint)

        // prevent newly inserted blocks from rotating via collisions
        insertedBlock.fiziksBody.allowsRotation = false

        currentlyMovingBlock = insertedBlock

        eventManager.postEvent(BlockInsertedEvent())
        return insertedBlock
    }
    
    func moveCMB(by vector: CGVector) {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        let oldPosition = fiziksBodyToMove.position
        let newPosition = CGPoint(x: oldPosition.x + vector.dx,
                                  y: oldPosition.y + vector.dy)
        fiziksBodyToMove.position = newPosition
    }
    
    func rotateCMB(by rotation: Double) {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        fiziksBodyToMove.zRotation += rotation
    }
    
    @discardableResult
    private func addBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newBlock = createBlock(ofShape: shape, at: position)
        level.gameObjects.append(newBlock)
        fiziksEngine.add(newBlock.fiziksBody)
        newBlock.fiziksBody.affectedByGravity = false
        newBlock.fiziksBody.velocity = .zero
        newBlock.fiziksBody.applyImpulse(GameWorldConstants.defaultBlockVelocity)
        return newBlock
    }
    
    private func createBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newFiziksBody = PathFiziksBody(path: shape.path,
                                           position: position,
                                           isDynamic: true,
                                           restitution: .zero,
                                           linearDamping: .zero,
                                           categoryBitMask: Block.categoryBitMask,
                                           collisionBitMask: Block.fallingCollisionBitMask,
                                           contactTestBitMask: Block.fallingContactTestBitMask)
        let newBlock = Block(fiziksBody: newFiziksBody, shape: shape)
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
        let platform = createPlatform(path: path, at: platformPosition)
        level.setMainPlatform(platform: platform)
        
        fiziksEngine.add(platform.fiziksBody)
        platform.fiziksBody.affectedByGravity = false
    }
    
    private func setLevelBoundaries() {
        // left boundary
        let leftPosition = CGPoint(x: dimensions.midX - GameWorldConstants.defaultPlatformBoundaryBuffer, y: dimensions.midY)
        level.leftBoundary = createLevelBoundary(at: leftPosition)
        
        // right boundary
        let rightPosition = CGPoint(x: dimensions.midX + GameWorldConstants.defaultPlatformBoundaryBuffer, y: dimensions.midY)
        level.rightBoundary = createLevelBoundary(at: rightPosition)
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
        
        
        self.fiziksEngine.insertBounds(fiziksEngineBoundingRect)
        fiziksEngine.fiziksContactDelegate = self
    }
    
    // MARK: Other methods
    private func createPlatform(path: CGPath, at position: CGPoint) -> Platform {
        let newFiziksBody = PathFiziksBody(path: path,
                                           position: position,
                                           zRotation: .zero,
                                           isDynamic: false,
                                           restitution: .zero,
                                           categoryBitMask: Platform.categoryBitMask,
                                           collisionBitMask: Platform.collisionBitMask,
                                           contactTestBitMask: Platform.contactTestBitMask)
        let newPlatform = Platform(fiziksBody: newFiziksBody, shape: PlatformShape(path: path))
        return newPlatform
    }
    
    private func removeObject(object: GameWorldObject) {
        level.gameObjects.removeAll(where: { $0 === object })
        fiziksEngine.delete(object.fiziksBody)
    }

    /// Creates a FiziksBody to represent the level boundary.
    private func createLevelBoundary(at position: CGPoint) -> FiziksBody {
        let width = GameWorldConstants.levelBoundaryWidth
        let rect = CGRect(origin: position, size: CGSize(width: width, height: dimensions.height))
        let path = CGPath.create(from: rect, centered: true)

        let fiziksBody = PathFiziksBody(path: path,
                                        position: position,
                                        categoryBitMask: CategoryMask.levelBoundary,
                                        collisionBitMask: CollisionMask.levelBoundary)
        fiziksEngine.add(fiziksBody)
        fiziksBody.isDynamic = false
        
        return fiziksBody
    }

    private func updatePowerupHeight() {
        level.updatePowerupLineHeight()
        powerupManager.createNextPowerup()
    }
}

extension GameWorld: FiziksContactDelegate {
    func didBegin(_ contact: FiziksContact) {
        // check whether it is contact between currently moving block & something else (not level boundaries)
        if let currentBlock = currentlyMovingBlock {
            if contact.contains(body: currentBlock.fiziksBody)
                && !contact.contains(body: level.leftBoundary)
                && !contact.contains(body: level.rightBoundary) {
                handlePlaceCMB()
            }

            if currentBlock.isGlueBlock {
                fiziksEngine.combine(bodyA: contact.bodyA, bodyB: contact.bodyB, at: contact.contactPoint)
            }
        }
    }

    func didEnd(_ contact: FiziksContact) {
        // pass
    }

    private func checkAndHandleContactPowerupLine(currentBlock: Block) {
        // landed block in contact with powerup line
        if let powerupLine = level.powerupLine, currentBlock.fiziksBody.contactTestBitMask == ContactTestMask.block {
            let pos = currentBlock.position
            let height = currentBlock.height

            // if above powerup line & stable (velocity = 0), then give powerup
            if pos.y + height / 2 > powerupLine.position.y
                && pos.y - height / 2 < powerupLine.position.y
                && currentBlock.fiziksBody.velocity == .zero {
                eventManager.postEvent(BlockTouchedPowerupLineEvent())
                updatePowerupHeight()
            }
        }
    }

    func handlePlaceCMB() {
        // allow gravity and rotation by collisions
        currentlyMovingBlock?.fiziksBody.affectedByGravity = true
        currentlyMovingBlock?.fiziksBody.allowsRotation = true

        // update collsion and contact mask
        currentlyMovingBlock?.fiziksBody.collisionBitMask = Block.collisionBitMask
        currentlyMovingBlock?.fiziksBody.contactTestBitMask = Block.contactTestBitMask

        var placedBlockCount = 0
        for gameObject in level.gameObjects {
            if gameObject.fiziksBody.categoryBitMask == CategoryMask.block {
                placedBlockCount += 1
            }
        }
        eventManager.postEvent(BlockPlacedEvent(totalBlocksInLevel: placedBlockCount))
        
        let towerHeight = findHighestPoint()
        eventManager.postEvent(TowerHeightIncreasedEvent(newHeight: towerHeight))

        self.currentlyMovingBlock = nil
    }

    /// Returns the y-coordinate of the highest point in the level
    private func findHighestPoint() -> Double {
        var maxY: Double = -.infinity
        level.gameObjects.forEach({ obj in
            if let block = obj as? Block, block !== currentlyMovingBlock {
                maxY = max(block.position.y + block.height / 2, maxY)
            }
        })

        return maxY
    }
}

// TODO: Move this to powerup
// extension to support powerups
//extension GameWorld {
//    func registerPowerupEvents() {
//        eventManager?.registerClosure(for: GluePowerupActivatedEvent.self, closure: { _ in
//            self.currentlyMovingBlock?.isGlueBlock = true
//        })
//        eventManager?.registerClosure(for: PlatformPowerupActivatedEvent.self, closure: { _ in
//            guard let newPlatform = self.createPowerupPlatform() else { return }
//            self.gameObjects.append(newPlatform)
//            self.fiziksEngine.add(newPlatform.fiziksBody)
//        })
//    }
//
//    // used when platform powerup is activated
//    private func createPowerupPlatform() -> Platform? {
//        guard let platform = platform else { return nil }
//        var count = 0
//        while count < GameWorldConstants.defaultTriesToFindPlatformPosition {
//            let rngX = Int(rng.next()) % Int(platform.width)
//            let newX = CGFloat(rngX) + platform.position.x - platform.width / 2
//            var newY = findHighestPoint() + GameWorldConstants.bufferFromHighestPoint
//            if let powerupLine = powerupLine {
//                newY = min(newY, powerupLine.position.y - GameWorldConstants.defaultPowerupPlatformHeight)
//            }
//            let newPosition = CGPoint(x: newX, y: newY)
//            let rect = CGRect(x: newPosition.x,
//                              y: newPosition.y,
//                              width: GameWorldConstants.defaultPowerupPlatformWidth,
//                              height: GameWorldConstants.defaultPowerupPlatformHeight)
//            let path = CGPath.create(from: rect)
//
//            let newPlatform = createPlatform(path: path, at: newPosition)
//
//            let otherBodies = gameObjects.map({ $0.fiziksBody })
//
//            if !fiziksEngine.isIntersecting(body: newPlatform.fiziksBody, otherBodies: otherBodies) {
//                return newPlatform
//            }
//
//            count += 1
//        }
//
//        return nil
//    }
//}

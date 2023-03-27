//
//  GameEngine.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SwiftUI

class GameEngine {
    
    static let defaultSeed: Int = 1
    
    static let defaultBlockVelocity = CGVector(dx: 0, dy: -8)
    
    static let defaultPlatformBoundaryBuffer: Double = 200
    
    let levelDimensions: CGRect
    
    var gameObjects: [any GameEngineObject]
    
    let fiziksEngine: FiziksEngine
    
    var eventManager: EventManager?
    
    var platform: Platform? {
        didSet {
            if let platform = platform {
                // boundaries set to have a buffer to allow blocks to fall off or creative gameplay
                
                // TODO: FIX THE POSITIONS OF THESE, NOT SURE WHY WEIRD POSITIONING
                let leftPosition = CGPoint(x: platform.position.x - GameEngine.defaultPlatformBoundaryBuffer, y: 0)
                let rightPosition = CGPoint(x: platform.position.x, y: 0)
                rightBoundary = createLevelBoundary(at: rightPosition)
                leftBoundary = createLevelBoundary(at: leftPosition)
                
                
            }
            
        }
    }
    
    var leftBoundary: FiziksBody? {
        didSet {
            // remove the old boundary
            if let oldValue = oldValue {
                fiziksEngine.delete(oldValue)
            }
        }
    }
    
    var rightBoundary: FiziksBody? {
        didSet {
            // remove the old boundary
            if let oldValue = oldValue {
                fiziksEngine.delete(oldValue)
            }
        }
    }
    
    // TODO: Add random generation of platform in the future
    private var rng: RandomNumberGeneratorWithSeed
    
    private weak var gameRenderer: GameRendererDelegate?
    
    private var shapeRandomizer: ShapeRandomizer
    
    private var currentlyMovingBlock: Block? {
        didSet {
            if currentlyMovingBlock == nil {
                insertNewBlock()
            }
        }
    }
    
    private var blockInsertionPoint: CGPoint {
        CGPoint(x: levelDimensions.width / 2,
                y: levelDimensions.height + 30)
    }
    
    init(levelDimensions: CGRect, seed: Int = GameEngine.defaultSeed) {
        self.levelDimensions = levelDimensions
        // Use leveldimensions to set size of level if needed, otherwise remove
        self.gameObjects = []

        // FiziksBodies will collide with walls at the sides,
        // but there is 100px above and below
        let fiziksEngineBoundingRect = CGRect(x: levelDimensions.minX,
                                              y: levelDimensions.minY - 100,
                                              width: levelDimensions.width,
                                              height: levelDimensions.height + 200)
        self.fiziksEngine = GameFiziksEngine(levelDimensions: levelDimensions, boundingRect: fiziksEngineBoundingRect)

        // TODO: pass in seed
        self.shapeRandomizer = ShapeRandomizer(possibleShapes: TetrisType.allCases, seed: 1)
        
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)

        fiziksEngine.fiziksContactDelegate = self
    }

    func setRenderer(gameRenderer: GameRendererDelegate) {
        self.gameRenderer = gameRenderer
    }
    
    func getReferencePoints() -> (left: CGPoint, right: CGPoint)? {
        guard let block = currentlyMovingBlock, let shape = currentlyMovingBlock?.shape as? TetrisShape else { return nil }
        let movingGameObjectBlock = GameObjectBlock(position: block.position, path: shape.path, rotation: block.rotation)
        let xPosLeft: Double = movingGameObjectBlock.position.x - movingGameObjectBlock.width / 2
        let xPosRight: Double = movingGameObjectBlock.position.x + movingGameObjectBlock.width / 2
        let yPos: Double = 0
        return (left: CGPoint(x: xPosLeft, y: yPos), right: CGPoint(x: xPosRight, y: yPos))
    }
    

    // This update method is called by the GameUpdater every frame.
    func update() {
        // MARK: Platform is always sampleplatform for now
        var newLevel = Level(blocks: [], platform: .samplePlatform)

        for object in gameObjects {
            if isOutOfBounds(object) {
                // TODO: Emit event that a block has gone out of bounds.
                removeObject(object: object)
                
                if object === currentlyMovingBlock {
                    currentlyMovingBlock = nil
                }
            }
            
            if object.fiziksBody.categoryBitMask == CategoryMask.block {
                let blockPosition = object.position
                // TODO: more elegant way besides downcasting?
                guard let block = object as? Block, let shape = block.shape as? TetrisShape else { continue }
                newLevel.add(block: GameObjectBlock(position: blockPosition, path: shape.path, rotation: block.rotation))
            }
        }

        gameRenderer?.renderLevel(level: newLevel, gameObjectBlocks: newLevel.blocks, gameObjectPlatform: newLevel.platform)

        // Get curr input and move block
        if let currInput = gameRenderer?.getCurrInput() {
            moveSideways(by: currInput.vector)
        }
    }
    
    @discardableResult
    func insertNewBlock() -> Block {
        let shape = shapeRandomizer.getShape()
        // TODO: Here for testing individual shapes rendering - remove once not needed
//         let shape = TetrisShape(type: .I)
        let insertedBlock = addBlock(ofShape: shape, at: blockInsertionPoint)
        fiziksEngine.setIsRotationAllowed(insertedBlock.fiziksBody, to: false)
        currentlyMovingBlock = insertedBlock
        return insertedBlock
    }
    
    /// Slides the currently-moving block only on the x-axis.
    func moveSideways(by displacement: CGVector) {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        let correctedDisplacement = CGVector(dx: displacement.dx, dy: 0)
        fiziksEngine.move(fiziksBodyToMove, by: correctedDisplacement)
    }

    /// Moves the currently-moving block downwards only.
    func moveDown(by displacement: CGVector) {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        let correctedDy = min(displacement.dy, 0)
        let correctedDisplacement = CGVector(dx: 0, dy: correctedDy)
        fiziksEngine.move(fiziksBodyToMove, by: correctedDisplacement)
    }

    /// Rotates the currently moving block clockwise by 90 degrees.
    func rotateClockwise() {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        fiziksEngine.rotate(fiziksBodyToMove, by: -Double.pi / 2)
    }

    /// Rotates the currently moving block counter-clockwise by 90 degrees.
    func rotateCounterClockwise() {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        fiziksEngine.rotate(fiziksBodyToMove, by: Double.pi / 2)
    }
    
    func setPlatform(position: CGPoint) {
        // TODO: Add random generation of platform sizes here
        let width = 200
        let height = 100
        
        let points = [CGPoint(x: 0, y: height),
                      CGPoint(x: width, y: height),
                      CGPoint(x: width, y: 0),
                      CGPoint(x: 0, y: 0)]
        
        
        let path = CGPath.create(from: points)

        // TODO: FIX THIS!
        let insertedPlatform = createPlatform(path: path, at: position.subtract(by: CGPoint(x: path.width / 2, y: 0)))
        
        platform = insertedPlatform

        gameObjects.append(insertedPlatform)
        fiziksEngine.add(insertedPlatform.fiziksBody)
        fiziksEngine.setAffectedByGravity(insertedPlatform.fiziksBody, to: false)
    }
    
    // TODO: this should eventually become private as we do not want the player
    // adding blocks
    @discardableResult
    private func addBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newBlock = createBlock(ofShape: shape, at: position)
        gameObjects.append(newBlock)
        fiziksEngine.add(newBlock.fiziksBody)
        fiziksEngine.setAffectedByGravity(newBlock.fiziksBody, to: false)
        fiziksEngine.setVelocity(newBlock.fiziksBody, to: GameEngine.defaultBlockVelocity)
        return newBlock
    }
    
    private func removeObject(object: GameEngineObject) {
        gameObjects.removeAll(where: { $0 === object })
        fiziksEngine.delete(object.fiziksBody)
    }

    // MARK: private methods
    private func createBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newFiziksBody = PathFiziksBody(path: shape.path,
                                           position: position,
                                           zRotation: 0,
                                           categoryBitMask: Block.categoryBitmask,
                                           collisionBitMask: Block.collisionBitmask,
                                           contactTestBitMask: Block.contactTestBitmask,
                                           isDynamic: true)
        let newBlock = Block(fiziksBody: newFiziksBody, shape: shape)
        return newBlock
    }

    private func createPlatform(path: CGPath, at position: CGPoint) -> Platform {
        let newFiziksBody = PathFiziksBody(path: path,
                                           position: position,
                                           zRotation: 0,
                                           categoryBitMask: Platform.categoryBitmask,
                                           collisionBitMask: Platform.collisionBitmask,
                                           contactTestBitMask: Platform.contactTestBitmask,
                                           isDynamic: false)
        let newPlatform = Platform(fiziksBody: newFiziksBody, shape: PlatformShape(path: path))
        return newPlatform
    }
    
    private func isOutOfBounds(_ obj: any GameEngineObject) -> Bool {
        let width = obj.shape.width
        let height = obj.shape.height
        let buffer = max(width, height)
        let pos = obj.position
        // doesn't include being above the level dimensions (so that objects can spawn from above)
        return pos.x - buffer > levelDimensions.maxX || pos.x + buffer < levelDimensions.minX || pos.y + buffer < 0
    }
    
    /// Creates  a FiziksBody to represent the level boundary.
    private func createLevelBoundary(at position: CGPoint) -> FiziksBody {
        let path = CGPath(rect: CGRect(x: position.x, y: position.y, width: 5, height: levelDimensions.height), transform: nil)
        let fiziksBody = PathFiziksBody(path: path, position: position)
        fiziksEngine.add(fiziksBody)
//        fiziksEngine.setAffectedByGravity(fiziksBody, to: false)
        fiziksEngine.setDynamicValue(fiziksBody, to: false)
        return fiziksBody
    }
}

extension GameEngine: FiziksContactDelegate {
    func didBegin(_ contact: FiziksContact) {
        // Once Block collides with another block/platform, Block should be affected by gravity
        // TODO: set the falling block friction to 0, test for collision normal to have a vertical component
        // update: tried checking for vertical component, i think there is always a tiny vertical component, so not a good check.
        if let currentBlock = currentlyMovingBlock {
            if contact.contains(body: currentBlock.fiziksBody)
                && !contact.contains(body: leftBoundary)
                && !contact.contains(body: rightBoundary) {
                fiziksEngine.setAffectedByGravity(currentBlock.fiziksBody, to: true)
                fiziksEngine.setIsRotationAllowed(currentBlock.fiziksBody, to: true)
                eventManager?.postEvent(BlockPlacedEvent())
                self.currentlyMovingBlock = nil
            }
        }
    }

    func didEnd(_ contact: FiziksContact) {
        // pass
    }
}

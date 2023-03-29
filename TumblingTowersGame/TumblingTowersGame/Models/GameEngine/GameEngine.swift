//
//  GameEngine.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SwiftUI

class GameEngine {

    private weak var gameRenderer: GameRendererDelegate?

    static let defaultBlockVelocity = CGVector(dx: 0, dy: -5)

    let levelDimensions: CGRect
    var gameEngineObjects: [any GameEngineObject]
    let fiziksEngine: FiziksEngine
    private var shapeRandomizer: ShapeRandomizer
    
    let eventManager: EventManager
    let achievementSystem: StatsTrackingSystem

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

    // TODO: expose API to allow adding of platforms instead of hard-coded platform
    private var platformPoints: [CGPoint] {
        let bottom: CGFloat = 20
        let top: CGFloat = bottom + 100
        let left: CGFloat = 0
        let right: CGFloat = levelDimensions.width
        return [CGPoint(x: left, y: top),
                CGPoint(x: right, y: top),
                CGPoint(x: right, y: bottom),
                CGPoint(x: left, y: bottom)]
        /*
        let bottom: CGFloat = 20
        let top: CGFloat = bottom + 30
        let left: CGFloat = levelDimensions.width / 2 - 100
        let right: CGFloat = levelDimensions.width / 2 + 100
        return [CGPoint(x: left, y: top),
                CGPoint(x: right, y: top),
                CGPoint(x: right, y: bottom),
                CGPoint(x: left, y: bottom)]
         */
    }

    init(levelDimensions: CGRect) {
        self.levelDimensions = levelDimensions
        // Use leveldimensions to set size of level if needed, otherwise remove
        self.gameEngineObjects = []

        // FiziksBodies will collide with walls at the sides,
        // but there is 100px above and below
        let fiziksEngineBoundingRect = CGRect(x: levelDimensions.minX,
                                              y: levelDimensions.minY - 100,
                                              width: levelDimensions.width,
                                              height: levelDimensions.height + 200)
        self.fiziksEngine = GameFiziksEngine(size: levelDimensions)
        self.fiziksEngine.insertBounds(fiziksEngineBoundingRect)

        // TODO: pass in seed
        self.shapeRandomizer = ShapeRandomizer(possibleShapes: TetrisType.allCases, seed: 1)
        
        self.eventManager = TumblingTowersEventManager()
        self.achievementSystem = StatsTrackingSystem(eventManager: eventManager)

        fiziksEngine.fiziksContactDelegate = self

        insertInitialPlatform()
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

        for object in gameEngineObjects {
            if object.fiziksBody.categoryBitMask == CategoryMask.block {
                let blockPosition = object.position
                // TODO: more elegant way besides downcasting?
                guard let block = object as? Block, let shape = block.shape as? TetrisShape else { continue }
                newLevel.add(block: GameObjectBlock(position: blockPosition, path: shape.path, rotation: block.rotation)
                )
            }
        }

        gameRenderer?.renderLevel(level: newLevel, gameObjectBlocks: newLevel.blocks, gameObjectPlatform: newLevel.platform)

        // Get curr input and move block
        if let currInput = gameRenderer?.getCurrInput() {
            moveCMBSideways(by: currInput.vector)
        }
    }

    @discardableResult
    func insertNewBlock() -> Block {
        let shape = shapeRandomizer.getShape()
        // TODO: Here for testing individual shapes rendering - remove once not needed
        // let shape = TetrisShape(type: .I)
        let insertedBlock = addBlock(ofShape: shape, at: blockInsertionPoint)
        currentlyMovingBlock = insertedBlock
        return insertedBlock
    }

    /// Slides the currently-moving block only on the x-axis.
    func moveCMBSideways(by displacement: CGVector) {
        let correctedDisplacement = CGVector(dx: displacement.dx, dy: 0)
        moveCMB(by: correctedDisplacement)
    }

    /// Moves the currently-moving block downwards only.
    func moveCMBDown(by displacement: CGVector) {
        let correctedDy = min(displacement.dy, 0)
        let correctedDisplacement = CGVector(dx: 0, dy: correctedDy)
        moveCMB(by: correctedDisplacement)
    }
    
    /// Rotates the currently moving block clockwise by 90 degrees.
    func rotateCMBClockwise() {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        fiziksBodyToMove.zRotation -= CGFloat.pi / 2
    }

    /// Rotates the currently moving block counter-clockwise by 90 degrees.
    func rotateCMBCounterClockwise() {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        fiziksBodyToMove.zRotation += CGFloat.pi / 2
    }

    // TODO: this should eventually become private as we do not want the player
    // adding blocks
    @discardableResult
    private func addBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newBlock = createBlock(ofShape: shape, at: position)
        gameEngineObjects.append(newBlock)
        fiziksEngine.add(newBlock.fiziksBody)
        newBlock.fiziksBody.affectedByGravity = false
        newBlock.fiziksBody.velocity = .zero
        newBlock.fiziksBody.applyImpulse(GameEngine.defaultBlockVelocity)
        return newBlock
    }

    // MARK: private methods
    private func createBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newFiziksBody = PathFiziksBody(path: shape.path,
                                           position: position,
                                           isDynamic: true,
                                           restitution: .zero,
                                           linearDamping: .zero,
                                           categoryBitMask: Block.categoryBitMask,
                                           collisionBitMask: Block.collisionBitMask,
                                           contactTestBitMask: Block.contactTestBitMask)
        let newBlock = Block(fiziksBody: newFiziksBody, shape: shape)
        return newBlock
    }

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

    private func insertInitialPlatform() {
        let path = CGPath.create(from: platformPoints)
        let center = CGPoint.arithmeticMean(points: platformPoints)
        let platformPosition = CGPoint(x: center.x - 400, y: center.y)

        let insertedPlatform = createPlatform(path: path, at: platformPosition)

        gameEngineObjects.append(insertedPlatform)
        fiziksEngine.add(insertedPlatform.fiziksBody)
        insertedPlatform.fiziksBody.affectedByGravity = false
    }
    
    private func moveCMB(by vector: CGVector) {
        guard let fiziksBodyToMove = currentlyMovingBlock?.fiziksBody else {
            return
        }
        let oldPosition = fiziksBodyToMove.position
        let newPosition = CGPoint(x: oldPosition.x + vector.dx,
                                  y: oldPosition.y + vector.dy)
        fiziksBodyToMove.position = newPosition
    }
}

extension GameEngine: FiziksContactDelegate {
    func didBegin(_ contact: FiziksContact) {
        // Once Block collides with another block/platform, Block should be affected by gravity
        guard let currentlyMovingFiziksBody = currentlyMovingBlock?.fiziksBody else {
            return
        }
        let currentlyMovingFiziksBodyId = ObjectIdentifier(currentlyMovingFiziksBody)
        if currentlyMovingFiziksBodyId == ObjectIdentifier(contact.bodyA)
            || currentlyMovingFiziksBodyId == ObjectIdentifier(contact.bodyB) {
            contact.bodyA.affectedByGravity = true
            contact.bodyB.affectedByGravity = true
            currentlyMovingBlock = nil
            eventManager.postEvent(BlockPlacedEvent())
        }
    }

    func didEnd(_ contact: FiziksContact) {
        // pass
    }
}

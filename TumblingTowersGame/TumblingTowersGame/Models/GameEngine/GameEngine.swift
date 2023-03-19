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
    
    var gameObjects: [any GameEngineObject]
    let fiziksEngine: FiziksEngine
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

    private var platformPoints: [CGPoint] {
        let bottom: CGFloat = 20
        let top: CGFloat = bottom + 30
        let left: CGFloat = levelDimensions.width / 2 - 100
        let right: CGFloat = levelDimensions.width / 2 + 100
        return [CGPoint(x: left, y: top),
                CGPoint(x: right, y: top),
                CGPoint(x: right, y: bottom),
                CGPoint(x: left, y: bottom)]
    }
    
    init(levelDimensions: CGRect) {
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
        self.shapeRandomizer = ShapeRandomizer(possibleShapes: TetrisShape.allCases, seed: 1)

        fiziksEngine.fiziksContactDelegate = self
        
        insertInitialPlatform()
    }

    func setRenderer(gameRenderer: GameRendererDelegate) {
        self.gameRenderer = gameRenderer
    }

    // This update method is called by the GameUpdater every frame.
    func update() {
        // MARK: Platform is always sampleplatform for now
        var newLevel = Level(blocks: [], platform: .samplePlatform)

        for object in gameObjects {
            if object.fiziksBody.categoryBitMask == CategoryMask.block {
                let blockPosition = object.position
                // TODO: hardcoded .I shape for now, need to get the shape from engine
                newLevel.add(block: GameObjectBlock(position: blockPosition, blockShape: .I))
            }
        }

        gameRenderer?.renderLevel(level: newLevel, gameObjectBlocks: newLevel.blocks, gameObjectPlatform: newLevel.platform)
    }
    
    @discardableResult
    func insertNewBlock() -> Block {
        let shape = shapeRandomizer.getShape()
        let insertedBlock = addBlock(ofShape: shape, at: blockInsertionPoint)
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

    // MARK: private methods
    private func createBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newFiziksBody = PathFiziksBody(path: shape.path,
                                           position: position,
                                           zRotation: 0,
                                           categoryBitMask: Block.categoryBitmask,
                                           collisionBitMask: Block.collisionBitmask,
                                           contactTestBitMask: Block.contactTestBitmask,
                                           isDynamic: true)
        let newBlock = Block(fiziksBody: newFiziksBody, path: shape.path)
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
        let newPlatform = Platform(fiziksBody: newFiziksBody, path: path)
        return newPlatform
    }
    
    private func insertInitialPlatform() {
        let path = CGPath.create(from: platformPoints)
        let center = CGPoint.arithmeticMean(points: platformPoints)
        let platformPosition = CGPoint(x: center.x - 400, y: center.y)

        let insertedPlatform = createPlatform(path: path, at: platformPosition)

        gameObjects.append(insertedPlatform)
        fiziksEngine.add(insertedPlatform.fiziksBody)
        fiziksEngine.setAffectedByGravity(insertedPlatform.fiziksBody, to: false)
    }
}

extension GameEngine: FiziksContactDelegate {
    func didBegin(_ contact: FiziksContact) {
        // Once Block collides with another block/platform, Block should be affected by gravity
        // TODO: set the falling block friction to 0, test for collision normal to have a vertical component
        // update: tried checking for vertical component, i think there is always a tiny vertical component, so not a good check.
        guard let currentlyMovingFiziksBody = currentlyMovingBlock?.fiziksBody else {
            return
        }
        let currentlyMovingFiziksBodyId = ObjectIdentifier(currentlyMovingFiziksBody)
        if currentlyMovingFiziksBodyId == ObjectIdentifier(contact.bodyA)
            || currentlyMovingFiziksBodyId == ObjectIdentifier(contact.bodyB) {
            fiziksEngine.setAffectedByGravity(contact.bodyA, to: true)
            fiziksEngine.setAffectedByGravity(contact.bodyB, to: true)
            currentlyMovingBlock = nil
        }
    }

    func didEnd(_ contact: FiziksContact) {
        // pass
    }
}

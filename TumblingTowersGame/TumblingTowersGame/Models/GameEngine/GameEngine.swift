//
//  GameEngine.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SwiftUI

class GameEngine {
    static let defaultBlockVelocity = CGVector(dx: 0, dy: -1)
    static let defaultInsertionPoint = CGPoint(x: 200, y: 300)
    
    var gameObjects: [any GameEngineObject]
    let fiziksEngine: FiziksEngine
    // var shapeRandomizer: ShapeRandomizer
    
    var currentlyMovingBlock: Block? {
        didSet(newBlock) {
            /*
            if newBlock == nil {
                insertNewBlock()
            }
             */
        }
    }
    
    init(levelDimensions: CGRect) {
        // Use leveldimensions to set size of level if needed, otherwise remove
        self.gameObjects = []
        self.fiziksEngine = GameFiziksEngine()
//        self.time = Date.now
        fiziksEngine.fiziksContactDelegate = self
    }
    
    func insertNewBlock(at location: CGPoint = defaultInsertionPoint) {
        // let shape = shapeRandomizer.get()
        let shape = TetrisShape.L
        let insertedBlock = addBlock(ofShape: shape, at: location)
        currentlyMovingBlock = insertedBlock
    }
    
    // TODO: once properly tested, this should be a private method and called when
    // the previous block touches the ground
    private func addBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        // TODO: shape should be randomized
        // https://tetris.fandom.com/wiki/Random_Generator
        let newBlock = createBlock(ofShape: shape, at: position)
        gameObjects.append(newBlock)
        fiziksEngine.add(newBlock.fiziksBody)
        fiziksEngine.setAffectedByGravity(newBlock.fiziksBody, to: false)
        fiziksEngine.setVelocity(newBlock.fiziksBody, to: GameEngine.defaultBlockVelocity)
        return newBlock
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

    private func createBlock(ofShape shape: TetrisShape, at position: CGPoint) -> Block {
        let newFiziksBody = PathFiziksBody(path: shape.path,
                                           position: position,
                                           zRotation: 0,
                                           categoryBitMask: Block.categoryBitmask,
                                           collisionBitMask: Block.collisionBitmask,
                                           contactTestBitMask: Block.contactTestBitmask,
                                           isDynamic: true)
        let newBlock = Block(fiziksBody: newFiziksBody)
        return newBlock
    }

//    private var time: Date = .now
//    private var leftoverTime: Double = 0.0
//    private let durationOfFrameFor60FPS = TimeInterval(1.0 / 60.0)
//    private var displayLink: CADisplayLink?
//    private var frameCount = 0
//    private weak var gameRenderer: GameRendererDelegate?
//
//    func start(gameRendererDelegate: GameRendererDelegate) {
//        gameRenderer = gameRendererDelegate
//        // Reset Game Engine here
//        createCADisplayLink()
//    }
//
//
//    func createCADisplayLink() {
//        time = Date()
//
//        // TODO: We need to facade DisplayLink out into our own refresh class also later
//        displayLink = CADisplayLink(target: self, selector: #selector(update))
//        displayLink?.add(to: .current, forMode: .common)
//    }
//
//    func pauseGame() {
//        displayLink?.isPaused = true
//    }
//
//    func unpauseGame() {
//        displayLink?.isPaused = false
//    }
//
//    func stopLevel() {
//        displayLink?.isPaused = true
//        displayLink?.invalidate()
//    }
//
//
//    @objc func update() {
//
//        let timeNow = Date()
//        let timePassed = timeNow.timeIntervalSince(time) + leftoverTime
//        time = timeNow
//
//        var framesPassed = timePassed.magnitude / durationOfFrameFor60FPS
//        while framesPassed > 1 {
////            physicsEngine.update(timePassed: durationOfFrameFor60FPS)
////            updateGameObjs()
////            updateBallEvents()
////            updateGameEvents()
//            if (frameCount.isMultiple(of: 60)) {
//                // Step every 1s instead (Temporary so that it doesnt keep printing)
//                step()
//            }
//
//            framesPassed -= 1
//            frameCount += 1
//        }
//        leftoverTime = framesPassed * durationOfFrameFor60FPS
//
//        render()
//
//    }
//
//    func step() {
//        print("----------")
//        print(gameObjects.count)
//        for object in gameObjects {
//            print(object.fiziksBody.position)
//        }
//
//    }
//
//    func render() {
//        gameRenderer?.rerender()
//    }


}

extension GameEngine: FiziksContactDelegate {
    func didBegin(_ contact: FiziksContact) {
        // Once Block collides with another block/platform, Block should be affected by gravity
        fiziksEngine.setAffectedByGravity(contact.bodyA, to: true)
        fiziksEngine.setAffectedByGravity(contact.bodyB, to: true)
        currentlyMovingBlock = nil
    }

    func didEnd(_ contact: FiziksContact) {
        // pass
    }
}

//
//  GameEngine.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SwiftUI

class GameEngine {

    private var time: Date
    private var leftoverTime: Double = 0.0
    private let durationOfFrameFor60FPS = TimeInterval(1.0 / 60.0)
    private var displayLink: CADisplayLink?
    private var frameCount = 0

    private weak var gameRenderer: GameRendererDelegate?

    //    var gameObjects: [any GameObject]
    var gameObjects: [GameObject]
    let fiziksEngine: FiziksEngine

    init(levelDimensions: CGRect) {
        // Use leveldimensions to set size of level if needed, otherwise remove

        time = Date.now
        self.gameObjects = [] // MARK: Change after fixing BiDictionary
        self.fiziksEngine = FiziksEngine()
    }

    func start(gameRendererDelegate: GameRendererDelegate) {
        gameRenderer = gameRendererDelegate
        // Reset Game Engine here

        createCADisplayLink()
    }

    func createCADisplayLink() {
        time = Date()

        // TODO: We need to facade DisplayLink out into our own refresh class also later
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .common)
    }

    func pauseGame() {
        displayLink?.isPaused = true
    }

    func unpauseGame() {
        displayLink?.isPaused = false
    }

    func stopLevel() {
        displayLink?.isPaused = true
        displayLink?.invalidate()
    }


    @objc func update() {

        let timeNow = Date()
        let timePassed = timeNow.timeIntervalSince(time) + leftoverTime
        time = timeNow

        var framesPassed = timePassed.magnitude / durationOfFrameFor60FPS
        while framesPassed > 1 {
//            physicsEngine.update(timePassed: durationOfFrameFor60FPS)
//            updateGameObjs()
//            updateBallEvents()
//            updateGameEvents()
            if (frameCount.isMultiple(of: 60)) {
                // Step every 1s instead (Temporary so that it doesnt keep printing)
                step()
            }

            framesPassed -= 1
            frameCount += 1
        }

        leftoverTime = framesPassed * durationOfFrameFor60FPS

        render()

    }

    func step() {
        var str = ""

        for object in gameObjects {
            str += "\(object.position)"
        }
        print(str)
    }

    func render() {
        gameRenderer?.rerender()
    }



    func addBlock(at position: CGPoint) {
        // TODO: shape should be randomized
        // https://tetris.fandom.com/wiki/Random_Generator
        let tetrisShape = TetrisShape.T
        let newObject = Block(fiziksShape: tetrisShape, position: position)
        gameObjects.append(newObject)
        fiziksEngine.add(newObject)
    }
}


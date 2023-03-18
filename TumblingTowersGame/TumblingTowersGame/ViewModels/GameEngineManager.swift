//
//  GameEngineManager.swift
//  Gyro
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SwiftUI
import SpriteKit

class GameEngineManager: ObservableObject {
    @Published var goalLinePosition: CGPoint = CGPoint()
    @Published var powerUpLinePosition: CGPoint = CGPoint(x: 500, y: 500)
    @Published var platformPosition: CGPoint = GameObjectPlatform.samplePlatform.position
    
    var level: Level = Level.sampleLevel
    @Published var levelBlocks: [GameObjectBlock] = [.sampleBlock]
    @Published var levelPlatform: GameObjectPlatform = .samplePlatform
    
    
    
    
    
    
    
    
    private var gameEngine: GameEngine
    private var lastTapLocation = Point(0, 0)
    private weak var mainGameMgr: MainGameManager?

    var inputSystem: InputSystem

    init(levelDimensions: CGRect) {
        self.gameEngine = GameEngine(levelDimensions: levelDimensions)

        inputSystem = TapInput()
    }
    
    func tapEvent(at: Point) {
        lastTapLocation = at
        // MARK: Debug print
        print("Tapped at " + String(at.x) + ", " + String(at.y))

        inputSystem.tapEvent(at: at)
    }

    func getInput() -> InputType {
        inputSystem.getInput()
    }

    func getPhysicsEngine() -> FiziksEngine {
        gameEngine.fiziksEngine
    }

    // Temp function for testing
    func addBlock(at: CGPoint) {
        gameEngine.insertNewBlock(at: at)
        print("Adding")
    }

    
    
    
    
    private var time: Date = .now
    private var leftoverTime: Double = 0.0
    private let durationOfFrameFor60FPS = TimeInterval(1.0 / 60.0)
    private var displayLink: CADisplayLink?
    private var frameCount = 0
    private weak var gameRenderer: GameRendererDelegate?
    
    func start(mainGameMgr: MainGameManager) {
        // Initialize level here and start it
        gameRenderer = self
        
//        gameEngine.start(gameRendererDelegate: self)
        inputSystem.start(levelWidth: mainGameMgr.deviceWidth, levelHeight: mainGameMgr.deviceHeight)

        self.mainGameMgr = mainGameMgr
        
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
        print("----------")
        var newLevel = Level(blocks: [], platform: level.platform)

        for object in gameEngine.gameObjects {
            print("\(object) \(object.fiziksBody.position)")
            if object.fiziksBody.categoryBitMask == CategoryMask.block {
                let blockPosition = object.fiziksBody.position
                // TODO: hardcoded .I shape for now, need to get the shape from engine
                newLevel.add(block: GameObjectBlock(position: blockPosition, blockShape: .I))
            }
        }
        level = newLevel
        levelBlocks = newLevel.blocks
        levelPlatform = newLevel.platform
    }

    func render() {
        gameRenderer?.rerender()
    }

    
    
}

extension GameEngineManager: GameRendererDelegate {
    func rerender() {
        objectWillChange.send()
    }
}


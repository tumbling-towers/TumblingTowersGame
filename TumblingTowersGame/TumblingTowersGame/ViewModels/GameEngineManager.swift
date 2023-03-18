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

    func start(mainGameMgr: MainGameManager) {
        // Initialize level here and start it

        gameEngine.start(gameRendererDelegate: self)
        inputSystem.start(levelWidth: mainGameMgr.deviceWidth, levelHeight: mainGameMgr.deviceHeight)

        self.mainGameMgr = mainGameMgr

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
}

extension GameEngineManager: GameRendererDelegate {
    func rerender() {
        objectWillChange.send()
    }
}


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
    private var gameUpdater: GameUpdater?

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
        gameEngine.addBlock(ofShape: TetrisShape.L, at: at)
        print("Adding")
    }

    

    func setUpLevelAndStartEngine(mainGameMgr: MainGameManager) {
        // Initialize level here and start it
        // gameRenderer = self

        gameUpdater = GameUpdater(gameEngine: gameEngine, gameRenderer: self)
        gameEngine.setRenderer(gameRenderer: self)

//        gameEngine.start(gameRendererDelegate: self)
        inputSystem.start(levelWidth: mainGameMgr.deviceWidth, levelHeight: mainGameMgr.deviceHeight)

        self.mainGameMgr = mainGameMgr
        
        gameUpdater?.createCADisplayLink()
        
        platformPosition = CGPoint(x: mainGameMgr.deviceWidth/2, y: mainGameMgr.deviceHeight-100)
    }
    
}

extension GameEngineManager: GameRendererDelegate {
    func rerender() {
        objectWillChange.send()
    }

    func renderLevel(level: Level, gameObjectBlocks: [GameObjectBlock], gameObjectPlatform: GameObjectPlatform) {
        self.level = level
        self.levelBlocks = gameObjectBlocks
        self.levelPlatform = gameObjectPlatform
    }
}


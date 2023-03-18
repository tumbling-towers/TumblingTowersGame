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
    private var lastTapLocation = CGPoint(x: 0, y: 0)
    private weak var mainGameMgr: MainGameManager?

    var inputSystem: InputSystem
    private var gameUpdater: GameUpdater?
    
    var levelDimensions: CGRect

    init(levelDimensions: CGRect) {
        self.levelDimensions = levelDimensions
        self.gameEngine = GameEngine(levelDimensions: levelDimensions)

        inputSystem = TapInput()
    }
    
    func tapEvent(at: CGPoint) {
        lastTapLocation = at
        // MARK: Debug print
        print("Tapped at \(at.x) ,  \(at.y)")

        inputSystem.tapEvent(at: adjustCoordinates(for: at))
    }

    func getInput() -> InputType {
        inputSystem.getInput()
    }

    func getPhysicsEngine() -> FiziksEngine {
        gameEngine.fiziksEngine
    }

    // Temp function for testing
    func addBlock(at: CGPoint) {
        gameEngine.addBlock(ofShape: TetrisShape.L, at: adjustCoordinates(for: at))
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
    
    /// GameEngine outputs coordinates with the origin at the bottom-left.
    /// This method converts it such that the origin is at the top-left.
    private func adjustCoordinates(for point: CGPoint) -> CGPoint {
        let newPoint = CGPoint(x: point.x, y: levelDimensions.height - point.y)
        return newPoint
    }
}

extension GameEngineManager: GameRendererDelegate {
    func rerender() {
        objectWillChange.send()
    }

    func renderLevel(level: Level, gameObjectBlocks: [GameObjectBlock], gameObjectPlatform: GameObjectPlatform) {
        self.level = level

        var invertedGameObjBlocks: [GameObjectBlock] = []

        for gameObjectBlock in gameObjectBlocks {
            var currBlock = gameObjectBlock
            currBlock.position = adjustCoordinates(for: currBlock.position)
            invertedGameObjBlocks.append(currBlock)
        }

        self.levelBlocks = invertedGameObjBlocks
        self.levelPlatform = gameObjectPlatform
    }
}


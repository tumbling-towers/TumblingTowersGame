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

        gameEngine.insertNewBlock()
    }
    
    func tapEvent(at location: CGPoint) {
        lastTapLocation = location
        // MARK: Debug print
        print("Tapped at \(location.x) ,  \(location.y)")

        inputSystem.tapEvent(at: adjustCoordinates(for: location))
    }

    func getInput() -> InputType {
        inputSystem.getInput()
    }

    func getPhysicsEngine() -> FiziksEngine {
        gameEngine.fiziksEngine
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
    
    func rotateCurrentBlock() {
        gameEngine.rotateClockwise()
    }
    
    /// GameEngine outputs coordinates with the origin at the bottom-left.
    /// This method converts it such that the origin is at the top-left.
    private func adjustCoordinates(for point: CGPoint) -> CGPoint {
        let newPoint = CGPoint(x: point.x, y: levelDimensions.height - point.y)
        return newPoint
    }
    
    private func transformRenderable(for block: GameObjectBlock) -> GameObjectBlock {
        // Flips the block vertically (mirror image) due to difference in coordinate system
        let path = UIBezierPath(cgPath: block.path)
        var flip = CGAffineTransformMakeScale(1, -1)
        flip = CGAffineTransformTranslate(flip, block.width / 2, -block.height / 2)
        path.apply(flip)
        let newPosition = adjustCoordinates(for: block.position)
        let transformedBlock = GameObjectBlock(position: newPosition, path: path.cgPath)
        return transformedBlock
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
            let transformedBlock = transformRenderable(for: gameObjectBlock)
            invertedGameObjBlocks.append(transformedBlock)
        }

        self.levelBlocks = invertedGameObjBlocks
        self.levelPlatform = gameObjectPlatform
    }

    func getCurrInput() -> InputType {
        inputSystem.getInput()
    }
}


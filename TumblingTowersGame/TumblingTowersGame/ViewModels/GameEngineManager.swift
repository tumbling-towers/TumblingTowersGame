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
    @Published var levelBlocks: [GameObjectBlock] = [.sampleBlock]
    @Published var levelPlatform: GameObjectPlatform = .samplePlatform
    
    var platformPosition: CGPoint? {
        get {
            gameEngine.platform?.position
        }
        set {
            if let newPosition = newValue {
                gameEngine.setPlatform(position: newPosition)
            }
        }
    }
    
    var platformRenderPosition: CGPoint? {
        guard let position = platformPosition,
              let width = platformPath?.width,
              let height = platformPath?.height else { return nil }
        
        // TODO: FIX THIS!
        let adjusted = adjustCoordinates(for: position)
        return adjusted.add(by: CGPoint(x: width / 2, y: -height / 2))
    }
    
    var platformPath: CGPath? {
        guard let platformShape = gameEngine.platform?.shape as? PlatformShape else { return nil }
        
        return platformShape.path
    }
    
    var referenceBox: CGRect? {
        guard let refPoints = gameEngine.getReferencePoints() else { return nil }
        
        let width = refPoints.right.x - refPoints.left.x
        return CGRect(x: refPoints.left.x, y: 0, width: width, height: 3000)
    }
    
    var level: Level = Level.sampleLevel
    
    private var gameEngine: GameEngine
    private var lastTapLocation = CGPoint(x: 0, y: 0)
    private weak var mainGameMgr: MainGameManager?

    var inputSystem: InputSystem
    private var gameUpdater: GameUpdater?
    
    var levelDimensions: CGRect

    init(levelDimensions: CGRect) {
        self.levelDimensions = levelDimensions
        self.gameEngine = GameEngine(levelDimensions: levelDimensions)

        inputSystem = GyroInput()

        gameEngine.insertNewBlock()
    }
    
    func tapEvent(at location: CGPoint) {
        lastTapLocation = location
        // MARK: Debug print
        print("Tapped at \(location.x) ,  \(location.y)")

        inputSystem.tapEvent(at: adjustCoordinates(for: location))
    }
    
    func resetInput() {
        inputSystem.resetInput()
    }

    func getInput() -> InputData {
        inputSystem.getInput()
    }

    func getPhysicsEngine() -> FiziksEngine {
        gameEngine.fiziksEngine
    }

    func setUpLevelAndStartEngine(mainGameMgr: MainGameManager) {
        // set up game loop
        gameUpdater = GameUpdater(gameEngine: gameEngine, gameRenderer: self)
        gameUpdater?.createCADisplayLink()
        
        // set up renderer
        gameEngine.setRenderer(gameRenderer: self)

        // set up input system
        inputSystem.start(levelWidth: mainGameMgr.deviceWidth, levelHeight: mainGameMgr.deviceHeight)

        self.mainGameMgr = mainGameMgr
        
        // set up initial platform
        platformPosition = CGPoint(x: mainGameMgr.deviceWidth/2, y: 100)
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

    func getCurrInput() -> InputData {
        inputSystem.getInput()
    }
}


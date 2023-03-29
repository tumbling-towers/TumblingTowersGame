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
    @Published var powerUpLinePosition: CGPoint = CGPoint()
    @Published var powerupLineDimensions: CGSize = CGSize()
    @Published var levelBlocks: [GameObjectBlock] = [.sampleBlock]
    @Published var levelPlatform: GameObjectPlatform = .samplePlatform
    
    private weak var mainGameMgr: MainGameManager?
    var eventManager: EventManager?
    
    // MARK: Game logic related attributes
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
    
    var level: Level = Level.sampleLevel
    
    var levelDimensions: CGRect
    
    private var gameEngine: GameEngine

    // MARK: UI/UX related attributes
    var inputSystem: InputSystem
    
    private var gameUpdater: GameUpdater?
    
    var platformRenderPosition: CGPoint? {
        guard let position = platformPosition else { return nil }
        
        return adjustCoordinates(for: position)
    }
    
    var platformPath: CGPath? {
        guard let platformShape = gameEngine.platform?.shape as? PlatformShape else { return nil }
        
        return platformShape.path
    }
    
    var referenceBox: CGRect? {
        guard let refPoints = gameEngine.getReferencePoints() else { return nil }

        let width = refPoints.right.x - refPoints.left.x
        return CGRect(x: refPoints.left.x - 1, y: 0, width: width + 2, height: 3000)
    }

    init(levelDimensions: CGRect) {
        self.levelDimensions = levelDimensions
        self.gameEngine = GameEngine(levelDimensions: levelDimensions)
        
        gameEngine.eventManager = eventManager

        inputSystem = TapInput()

        gameEngine.insertNewBlock()
    }

    func dragEvent(offset: CGSize) {
        inputSystem.dragEvent(offset: offset)
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
        gameEngine.rotateCMBClockwise()
    }

    /// GameEngine outputs coordinates with the origin at the bottom-left.
    /// This method converts it such that the origin is at the top-left.
    private func adjustCoordinates(for point: CGPoint) -> CGPoint {
        let newPoint = CGPoint(x: point.x, y: levelDimensions.height - point.y)
        return newPoint
    }

    private func transformRenderable(for block: GameObjectBlock) -> GameObjectBlock {
        // Flips the block vertically (mirror image) due to difference in coordinate system
        let path = transformPath(path: block.path, width: block.width, height: block.height)
        let newPosition = adjustCoordinates(for: block.position)
        let transformedBlock = GameObjectBlock(position: newPosition, path: path)
        return transformedBlock
    }
    
    private func transformPath(path: CGPath, width: Double, height: Double) -> CGPath {
        let path = UIBezierPath(cgPath: path)
        var flip = CGAffineTransformMakeScale(1, -1)
        flip = CGAffineTransformTranslate(flip, width / 2, -height / 2)
        path.apply(flip)
        return path.cgPath
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
        
        if let powerupLine = gameEngine.powerupLine {
            powerUpLinePosition = adjustCoordinates(for: powerupLine.position)
                                  .add(by: CGVector(dx: -powerupLineDimensions.width / 2,
                                                    dy: 0))
            powerupLineDimensions = CGSize(width: powerupLine.shape.width, height: powerupLine.shape.height)
        }

        self.levelBlocks = invertedGameObjBlocks
        self.levelPlatform = gameObjectPlatform
    }

    func getCurrInput() -> InputData {
        inputSystem.getInput()
    }
}

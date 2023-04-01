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
    @Published var levelBlocks: [GameObjectBlock] = []
    @Published var levelPlatforms: [GameObjectPlatform] = []
    
    private weak var mainGameMgr: MainGameManager?
    var eventManager: EventManager? {
        didSet {
            gameEngine.eventManager = eventManager
            registerEvents()
        }
    }
    
    // MARK: Game logic related attributes
    var platformPosition: CGPoint? {
        get {
            gameEngine.platform?.position
        }
        set {
            if let newPosition = newValue {
                gameEngine.setInitialPlatform(position: newPosition)
            }
        }
    }
    
    var powerup: Powerup.Type?
    
    var level: Level = Level.sampleLevel
    
    var levelDimensions: CGRect
    
    private var gameEngine: GameEngine

    // MARK: UI/UX related attributes
    var inputSystem: InputSystem
    
    private var gameUpdater: GameUpdater?

    var gameMode: GameMode = SurvivalGameMode(eventMgr: TumblingTowersEventManager())
    
    var referenceBox: CGRect? {
        guard let refPoints = gameEngine.getReferencePoints() else { return nil }

        let width = refPoints.right.x - refPoints.left.x
        return CGRect(x: refPoints.left.x - 1, y: 0, width: width + 2, height: 3000)
    }

    init(levelDimensions: CGRect, eventManager: EventManager) {
        self.levelDimensions = levelDimensions
        
        self.gameEngine = GameEngine(levelDimensions: levelDimensions)
        self.eventManager = eventManager
        
        gameEngine.eventManager = eventManager

        inputSystem = TapInput()
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
        // set up renderer
        gameEngine.setRenderer(gameRenderer: self)

        self.mainGameMgr = mainGameMgr
    }

    func startGame(gameMode: Constants.GameModeTypes) {
        // set up game loop
        gameUpdater = GameUpdater(gameEngine: gameEngine, gameRenderer: self)
        gameUpdater?.createCADisplayLink()

        // set up game mode
        if let eventManager = eventManager {
            if gameMode == .SURVIVAL {
                self.gameMode = SurvivalGameMode(eventMgr: eventManager)
            } else if gameMode == .RACECLOCK {
                self.gameMode = RaceTimeGameMode(eventMgr: eventManager)
            }
        }

        // set up game in game engine
        gameEngine.startGame()

        // set up initial platform
        if let mainGameMgr = mainGameMgr {
            platformPosition = CGPoint(x: mainGameMgr.deviceWidth/2, y: 100)
        }
    }

    func rotateCurrentBlock() {
        gameEngine.rotateCMBClockwise()
    }
    
    func usePowerup() {
        guard let powerup = powerup else { return }
        eventManager?.postEvent(PowerupButtonTappedEvent(type: powerup))
        self.powerup = nil
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
        // TODO: Don't return a new block
        let transformedBlock = GameObjectBlock(position: newPosition, path: path, isGlue: block.isGlue)
        return transformedBlock
    }
    
    private func transformPath(path: CGPath, width: Double, height: Double) -> CGPath {
        let path = UIBezierPath(cgPath: path)
        var flip = CGAffineTransformMakeScale(1, -1)
        flip = CGAffineTransformTranslate(flip, width / 2, -height / 2)
        path.apply(flip)
        return path.cgPath
    }
    
    private func registerEvents() {
        eventManager?.registerClosure(for: PowerupAvailableEvent.self, closure: { event in
            switch event {
            case let powerupAvailableEvent as PowerupAvailableEvent:
                self.powerup = powerupAvailableEvent.type
            default:
                return
            }
        })
    }
}

extension GameEngineManager: GameRendererDelegate {
    func rerender() {
        objectWillChange.send()
    }

    func renderLevel(level: Level, gameObjectBlocks: [GameObjectBlock], gameObjectPlatforms: [GameObjectPlatform]) {
        self.level = level

        var invertedGameObjBlocks: [GameObjectBlock] = []
        var invertedGameObjPlatforms: [GameObjectPlatform] = []

        for gameObjectBlock in gameObjectBlocks {
            let transformedBlock = transformRenderable(for: gameObjectBlock)
            invertedGameObjBlocks.append(transformedBlock)
        }
        
        for var platform in gameObjectPlatforms {
            let transformedPlatformPosition = adjustCoordinates(for: platform.position)
            platform.position = transformedPlatformPosition
            invertedGameObjPlatforms.append(platform)
        }
        
        if let powerupLine = gameEngine.powerupLine {
            powerUpLinePosition = adjustCoordinates(for: powerupLine.position)
                                  .add(by: CGVector(dx: -powerupLineDimensions.width / 2,
                                                    dy: 0))
            powerupLineDimensions = CGSize(width: powerupLine.shape.width, height: powerupLine.shape.height)
        }

        self.levelBlocks = invertedGameObjBlocks
        self.levelPlatforms = invertedGameObjPlatforms
    }

    func getCurrInput() -> InputData {
        inputSystem.getInput()
    }
}

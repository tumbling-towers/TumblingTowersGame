//
//  GameEngineManager.swift
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SwiftUI
import SpriteKit

class GameEngineManager: ObservableObject {
    @Published var goalLinePosition = CGPoint()
    @Published var powerUpLinePosition = CGPoint()
    @Published var powerupLineDimensions = CGSize()
    @Published var levelBlocks: [GameObjectBlock] = []
    @Published var levelPlatforms: [GameObjectPlatform] = []
    @Published var powerups: [Powerup.Type?] = [Powerup.Type?](repeating: nil, count: 5)
    @Published var achievements: [DisplayableAchievement] = []

    var playerId = UUID()

    var eventManager: EventManager?
    var storageManager: StorageManager

    // MARK: Game logic related attributes
    var platformPosition: CGPoint? {
        get {
            gameEngine.level.mainPlatform?.position
        }
    }

    var levelDimensions: CGRect

    private var gameEngine: GameEngine

    // MARK: UI/UX related attributes
    var inputSystem: InputSystem

    private var gameUpdater: GameUpdater?

    var gameMode: GameMode? {
        gameEngine.gameMode
    }

    var referenceBox: CGRect? {
        guard let refPoints = gameEngine.gameWorld.referencePoints else { return nil }

        let width = refPoints.right.x - refPoints.left.x
        return CGRect(x: refPoints.left.x - 1, y: 0, width: width + 2, height: 3_000)
    }

    var timeRemaining: Int {
        if let currTime = gameMode?.time {
            return currTime
        } else {
            return 0
        }
    }

    var score: Int {
        if let currScore = gameMode?.score {
            return currScore
        } else {
            return 0
        }
    }

    var gameEnded: Bool {
        if let ended = gameMode?.isGameEnded {
            return ended
        } else {
            return false
        }
    }

    var gameEndMainMessage: String {
        if let msg = gameMode?.gameEndMainMessage {
            return msg
        } else {
            return "The game has ended."
        }
    }

    var gameEndSubMessage: String {
        if let msg = gameMode?.gameEndSubMessage {
            return msg
        } else {
            return "Please try again!"
        }
    }

    init(levelDimensions: CGRect, eventManager: EventManager, inputType: InputSystem.Type, storageManager: StorageManager) {
        self.levelDimensions = levelDimensions
        self.eventManager = eventManager
        self.storageManager = storageManager
        self.gameEngine = GameEngine(levelDimensions: levelDimensions, eventManager: eventManager, playerId: playerId, storageManager: storageManager)

        inputSystem = inputType.init()

        registerEvents()
        updateAchievements()
    }

    // TODO: REMOVE THIS
//    func changeInput(to inputType: Constants.GameInputTypes) {
//        let inputClass = Constants.getGameInputType(fromGameInputType: inputType)
//        if let inputClass = inputClass {
//            inputSystem = inputClass.init()
//        }
//    }
    
    func dragEvent(offset: CGSize) {
        inputSystem.dragEvent(offset: offset)
    }
    
    func resetInput() {
        inputSystem.resetInput()
    }

    func getPhysicsEngine() -> FiziksEngine {
        gameEngine.gameWorld.fiziksEngine
    }

    func startGame(gameMode: Constants.GameModeTypes) {
        // set up game loop
        gameUpdater = GameUpdater(runThisEveryFrame: update)
        gameUpdater?.createCADisplayLink()

        // set up game mode
        let gameModeClass = Constants.getGameModeType(from: gameMode)
        if let eventManager = eventManager, let gameModeClass = gameModeClass {
            self.gameEngine.gameMode = gameModeClass.init(eventMgr: eventManager, playerId: playerId, levelHeight: levelDimensions.height)
        }

        // set up game in game engine
        gameEngine.startGame()
    }

    func stopGame() {
        eventManager?.postEvent(GameEndedEvent(playerId: playerId, endState: .NONE))
    }

    func resetGame() {
        gameEngine.resetGame()
        gameMode?.resetGame()
    }

    private lazy var update = { [weak self] () -> Void in
        self?.updateGameEngine()
        self?.renderCurrentFrame()
        self?.updateAchievements()
    }

    func updateGameEngine() {
        gameEngine.update()
        let currInput = inputSystem.calculateInput()

        gameEngine.moveCMBSideways(by: currInput.vector)
        gameEngine.moveCMBDown(by: currInput.vector)

    }

    func renderCurrentFrame() {
        let levelToRender = convertLevel(gameWorldLevel: gameEngine.gameWorld.level)
        renderLevel(gameObjectBlocks: levelToRender.blocks, gameObjectPlatforms: levelToRender.platforms)
        rerender()
    }

    func rotateCurrentBlock() {
        gameEngine.rotateCMBClockwise()
    }

    func usePowerup(at idx: Int) {
        eventManager?.postEvent(PowerupButtonTappedEvent(idx: idx, for: gameEngine.gameWorld))
        self.powerups[idx] = nil
    }
    
    func pause() {
        gameUpdater?.pauseGame()
        gameEngine.pauseGame()
        gameMode?.pauseGame()
    }
    
    func unpause() {
        gameUpdater?.unpauseGame()
        gameEngine.unpauseGame()
        gameMode?.resumeGame()
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
        let transformedBlock = GameObjectBlock(position: newPosition, path: path, specialProperties: block.specialProperties)
        return transformedBlock
    }
    
    private func convertLevel(gameWorldLevel: GameWorldLevel) -> Level {
        var blocks: [GameObjectBlock] = []
        var platforms: [GameObjectPlatform] = []
        
        for object in gameEngine.level.gameObjects {
            if type(of: object) == Block.self {
                guard let block = object as? Block, let tetrisShape = block.shape as? TetrisShape else { continue }
                blocks.append(GameObjectBlock(position: block.position, path: tetrisShape.path, rotation: block.rotation, specialProperties: block.specialProperties))
            } else if type(of: object) == Platform.self {
                guard object is Platform else { continue }
                platforms.append(GameObjectPlatform(position: object.position, width: object.width, height: object.height))
            }
        }
        
        return Level(blocks: blocks, platforms: platforms)
    }

    private func transformPath(path: CGPath, width: Double, height: Double) -> CGPath {
        let path = UIBezierPath(cgPath: path)
        var flip = CGAffineTransformMakeScale(1, -1)
        flip = CGAffineTransformTranslate(flip, width / 2, -height / 2)
        path.apply(flip)
        return path.cgPath
    }

    private func registerEvents() {
        eventManager?.registerClosure(for: PowerupAvailableEvent.self, closure: powerupAvailableEventFired)
        eventManager?.registerClosure(for: GameEndedEvent.self, closure: stopGameEventFired)
    }

    private lazy var powerupAvailableEventFired = { [weak self] (_ event: Event) -> Void in
        if let powerupAvailableEvent = event as? PowerupAvailableEvent,
           powerupAvailableEvent.gameWorld === self?.gameEngine.gameWorld {
                self?.powerups[powerupAvailableEvent.idx] = powerupAvailableEvent.type
        }
    }

    private lazy var stopGameEventFired = { [weak self] (_ event: Event) -> Void in
        if let gameEndEvent = event as? GameEndedEvent {
            self?.gameUpdater?.stopLevel()
            self?.gameEngine.stopGame()
            self?.gameMode?.endGame(endedBy: gameEndEvent.playerId, endState: gameEndEvent.endState)
        }
    }
    
    private func updateAchievements() {
        var newAchievements = [DisplayableAchievement]()
        for achievement in gameEngine.achiementSystem.getUpdatedAchievements() {
            let newAchievement = DisplayableAchievement(id: UUID(),
                                                        name: achievement.name,
                                                        description: achievement.description,
                                                        goal: achievement.goal,
                                                        achieved: achievement.achieved)
            newAchievements.append(newAchievement)
        }
        achievements = newAchievements
    }
}

extension GameEngineManager: GameRendererDelegate {
    func rerender() {
        objectWillChange.send()
    }

    func renderLevel(gameObjectBlocks: [GameObjectBlock], gameObjectPlatforms: [GameObjectPlatform]) {
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

        if let powerupLine = gameEngine.level.powerupLine {
            powerUpLinePosition = adjustCoordinates(for: powerupLine.position)
                                  .add(by: CGVector(dx: -powerupLineDimensions.width / 2,
                                                    dy: 0))
            powerupLineDimensions = CGSize(width: powerupLine.dimensions.width, height: powerupLine.dimensions.height)
        }

        self.levelBlocks = invertedGameObjBlocks
        self.levelPlatforms = invertedGameObjPlatforms
    }

    func getCurrInput() -> InputData {
        inputSystem.calculateInput()
    }
}

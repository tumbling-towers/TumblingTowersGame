//
//  GameEngineManager.swift
//
//  Created by Elvis on 13/3/23.
//

import Foundation
import SpriteKit
import Fiziks

class GameEngineManager {
    var playerId = UUID()

    var eventManager: EventManager?
    var storageManager: StorageManager

    // MARK: Game logic related attributes
    var platformPosition: CGPoint? {
        gameEngine.level.mainPlatform?.position
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
        guard let refPoints = gameEngine.gameWorld.referencePoints else {
            return nil
        }

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

    weak var rendererDelegate: GameRendererDelegate?

    var powerups: [Powerup.Type?] = [Powerup.Type?](repeating: nil, count: 5)

    var physicsEngine: FiziksEngine {
        gameEngine.gameWorld.fiziksEngine
    }

    init(levelDimensions: CGRect,
         eventManager: EventManager,
         inputType: InputSystem.Type,
         storageManager: StorageManager,
         playersMode: PlayersMode?) {
        self.levelDimensions = levelDimensions
        self.eventManager = eventManager
        self.storageManager = storageManager
        self.gameEngine = GameEngine(levelDimensions: levelDimensions,
                                     eventManager: eventManager,
                                     playerId: playerId,
                                     storageManager: storageManager,
                                     playersMode: playersMode)

        inputSystem = inputType.init()

        registerEvents()
    }

    func setRendererDelegate(_ renderer: GameRendererDelegate) {
        self.rendererDelegate = renderer
    }

    func dragEvent(offset: CGSize) {
        inputSystem.dragEvent(offset: offset)
    }

    func resetInput() {
        inputSystem.resetInput()
    }

    func startGame(gameMode: Constants.GameModeTypes) {
        // set up game loop
        gameUpdater = GameUpdater(runThisEveryFrame: update)
        gameUpdater?.createCADisplayLink()

        // set up game mode
        let gameModeClass = Constants.getGameModeType(from: gameMode)
        if let eventManager = eventManager, let gameModeClass = gameModeClass {
            self.gameEngine.gameMode = gameModeClass.init(eventMgr: eventManager,
                                                          playerId: playerId,
                                                          levelHeight: levelDimensions.height)
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
    }

    func updateGameEngine() {
        gameEngine.update()
        let currInput = inputSystem.calculateInput()

        gameEngine.moveCMBSideways(by: currInput.vector)
        gameEngine.moveCMBDown(by: currInput.vector)

    }

    func renderCurrentFrame() {
        if let referenceBoxToUpdate = referenceBox, let gameModeToUpdate = gameMode {
            rendererDelegate?.updateViewVariables(referenceBoxToUpdate: referenceBoxToUpdate,
                                                  powerupsToUpdate: powerups,
                                                  gameModeToUpdate: gameModeToUpdate,
                                                  timeRemainingToUpdate: timeRemaining,
                                                  scoreToUpdate: score,
                                                  gameEndedToUpdate: gameEnded,
                                                  gameEndMainMessageToUpdate: gameEndMainMessage,
                                                  gameEndSubMessageToUpdate: gameEndSubMessage)
        }
//        let levelToRender = gameEngine.gameWorld.level

        if let powerupLine = gameEngine.level.powerupLine {
            rendererDelegate?.renderCurrentFrame(gameObjects: gameEngine.level.gameObjects, powerUpLine: powerupLine)
        }
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
}

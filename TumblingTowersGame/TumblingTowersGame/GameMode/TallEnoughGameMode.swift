//
//  TallEnoughGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 12/4/23.
//

import Foundation

class TallEnoughGameMode: GameMode {

    static var name = Constants.GameModeTypes.RACECLOCK.rawValue
    static var description = "Build your tower as high as you can... Until the \(powerupLinesToHit)th (singleplayer) / \(powerupLinesToHit / shortLevelMultiplier)th (multiplayer) powerup line! DO NOT drop more than \(blocksDroppedThreshold) blocks! Score decays over time! Bonus score time: \(scoreTimeWithBonusScore)s"

    var realTimeTimer = GameTimer()
    var eventMgr: EventManager

    // MARK: Constants for this game mode
    static let powerupLinesToHit = 10
    static let blocksDroppedThreshold = 20
    
    let scoreBlocksPlacedMultiplier = 10
    let scoreBlocksDroppedMultiplier = 15
    static let shortLevelMultiplier = 2
    static let scoreTimeWithBonusScore = 60

    // MARK: Tracking State of Game
    var currPowerupLineAmt = 0
    var currBlocksPlaced = 0
    var currBlocksDropped = 0
    let playerId: UUID

    var isStarted = false
    var isGameEnded = false

    var shortLevel = false

    // MARK: Multiplayer States
    var isEndedByOtherPlayer = false
    var overwriteGameState: Constants.GameState?

    required init(eventMgr: EventManager, playerId: UUID, levelHeight: CGFloat) {
        self.eventMgr = eventMgr
        self.playerId = playerId

        if levelHeight < Constants.levelNotTallEnoughThreshold {
            shortLevel = true
        }

        // Register all events that affect game state
        eventMgr.registerClosure(for: BlockTouchedPowerupLineEvent.self, closure: touchedPowerupLine)
        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
    }

    func update() {
        if gameState != .RUNNING && gameState != .PAUSED {
            eventMgr.postEvent(GameEndedEvent(playerId: playerId, endState: gameState))
        }
    }

    var gameState: Constants.GameState {
        if let overwriteGameState = overwriteGameState {
            return overwriteGameState
        }

        if currPowerupLineAmt >= TallEnoughGameMode.powerupLinesToHit {
            return .WIN
        } else if shortLevel && currPowerupLineAmt >= TallEnoughGameMode.powerupLinesToHit / TallEnoughGameMode.shortLevelMultiplier {
            return .WIN
        } else if currBlocksDropped >= TallEnoughGameMode.blocksDroppedThreshold {
            return .LOSE
        }

        if isStarted {
            return .RUNNING
        } else {
            return .NONE
        }
    }

    var score: Int {
        max(TallEnoughGameMode.scoreTimeWithBonusScore - realTimeTimer.count
            + currBlocksPlaced * scoreBlocksPlacedMultiplier
            - currBlocksDropped * scoreBlocksDroppedMultiplier, 0)
    }

    var time: Int {
        realTimeTimer.count
    }

    var gameEndMainMessage: String {
        if gameState == .WIN {
            return Constants.defaultWinMainString
        } else if gameState == .LOSE {
            return Constants.defaultLoseMainString
        }

        return ""
    }

    var gameEndSubMessage: String {
        if gameState == .WIN {
            if isEndedByOtherPlayer {
                return "Your opponent dropped too many blocks!"
            } else {
                return "You reached enough powerup lines!"
            }
        } else if gameState == .LOSE {
            if isEndedByOtherPlayer {
                return "Your opponent reached enough powerup lines first!"
            } else {
                return "You dropped too many blocks!"
            }
        }
        return ""
    }

    func resetGame() {
        isStarted = false
        isGameEnded = false
        currBlocksPlaced = 0
        currBlocksDropped = 0
        currPowerupLineAmt = 0
        realTimeTimer = GameTimer()

        isEndedByOtherPlayer = false
        overwriteGameState = nil
    }

    func startGame() {
        isStarted = true
        realTimeTimer.start(timeInSeconds: 0, isCountsUp: true)
    }

    func pauseGame() {
        realTimeTimer.pause()
    }

    func resumeGame() {
        realTimeTimer.resume()
    }

    func endGame(endedBy: UUID, endState: Constants.GameState) {
        isGameEnded = true
        realTimeTimer.stop()

        if endedBy != playerId {
            isEndedByOtherPlayer = true

            if endState == .WIN {
                // Other player reached enough powerup line first
                overwriteGameState = .LOSE
            } else if endState == .LOSE {
                // Other player dropped too many blocks
                overwriteGameState = .WIN
            }

        }
    }

    private lazy var touchedPowerupLine = { [weak self] (_ event: Event) -> Void in
        if let touchedEvent = event as? BlockTouchedPowerupLineEvent, touchedEvent.playerId == self?.playerId {
            self?.currPowerupLineAmt += 1
        }
    }

    private lazy var blockPlaced = { [weak self] (_ event: Event) -> Void in
        if let placedEvent = event as? BlockPlacedEvent, placedEvent.playerId == self?.playerId {
            self?.currBlocksPlaced = placedEvent.totalBlocksInLevel
        }
    }

    private lazy var blockDropped = { [weak self] (_ event: Event) -> Void in
        if let droppedEvent = event as? BlockDroppedEvent, droppedEvent.playerId == self?.playerId {
            self?.currBlocksDropped += 1
        }
    }

}

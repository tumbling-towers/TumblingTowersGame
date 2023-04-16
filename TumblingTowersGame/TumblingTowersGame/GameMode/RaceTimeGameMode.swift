//
//  RaceTimeGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class RaceTimeGameMode: GameMode {

    static var name = Constants.GameModeTypes.RACECLOCK.rawValue
    static var description = "Place \(blocksToPlace) blocks in \(timeToPlaceBy)s (singleplayer) / \(timeToPlaceBy / shortLevelTimeMultiplier)s (multiplayer)!"

    var realTimeTimer = GameTimer()
    var eventMgr: EventManager

    // MARK: Constants for this game mode
    static let blocksToPlace = 30
    static let timeToPlaceBy = 60
    let scoreTimeLeftMultiplier = 10
    let scoreBlocksPlacedMultiplier = 10
    let scoreBlocksDroppedMultiplier = 25
    static let shortLevelTimeMultiplier = 2

    // MARK: Tracking State of Game
    private var currBlocksPlaced = 0
    private var currBlocksDropped = 0
    private let playerId: UUID

    var isStarted = false
    var isGameEnded = false

    private var shortLevel = false

    // MARK: Multiplayer States
    private var isEndedByOtherPlayer = false
    private var overwriteGameState: Constants.GameState?
    private var otherPlayerRanOutOfTime = false

    required init(eventMgr: EventManager, playerId: UUID, levelHeight: CGFloat) {
        self.eventMgr = eventMgr
        self.playerId = playerId

        if levelHeight < Constants.levelNotTallEnoughThreshold {
            shortLevel = true
        }

        // Register all events that affect game state
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

        if currBlocksPlaced >= RaceTimeGameMode.blocksToPlace {
            return .WIN
        } else if realTimeTimer.count <= 0 {
            return .LOSE
        }

        if isStarted {
            return .RUNNING
        } else {
            return .NONE
        }
    }

    var score: Int {
        max(realTimeTimer.count * scoreTimeLeftMultiplier
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
            return "You beat the clock!"
        } else if gameState == .LOSE {
            if isEndedByOtherPlayer {
                if otherPlayerRanOutOfTime {
                    // Other player ran out of time
                    return "You ran out of time!"
                } else {
                    // Other player stacked enough blocks faster
                    return "You were too slow!"
                }
            } else {
                return "You ran out of time!"
            }
        }
        return ""
    }

    func resetGame() {
        isStarted = false
        isGameEnded = false
        currBlocksPlaced = 0
        currBlocksDropped = 0
        realTimeTimer = GameTimer()

        isEndedByOtherPlayer = false
        overwriteGameState = nil
        otherPlayerRanOutOfTime = false
    }

    func startGame() {
        isStarted = true
        if shortLevel {
            realTimeTimer.start(timeInSeconds: RaceTimeGameMode.timeToPlaceBy / RaceTimeGameMode.shortLevelTimeMultiplier, isCountsUp: false)
        } else {
            realTimeTimer.start(timeInSeconds: RaceTimeGameMode.timeToPlaceBy, isCountsUp: false)
        }
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
                overwriteGameState = .LOSE
                otherPlayerRanOutOfTime = false
            } else if endState == .LOSE {
                overwriteGameState = .LOSE
                otherPlayerRanOutOfTime = true
            }

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

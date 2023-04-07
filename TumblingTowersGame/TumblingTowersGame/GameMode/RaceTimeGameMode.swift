//
//  RaceTimeGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class RaceTimeGameMode: GameMode {

    var name = "Race Against the Clock"

    var realTimeTimer = GameTimer()
    var eventMgr: EventManager

    // MARK: Constants for this game mode
    let blocksToPlace = 5
    let timeToPlaceBy = 15
    let scoreTimeLeftMultiplier = 10
    let scoreBlocksPlacedMultiplier = 10
    let scoreBlocksDroppedMultiplier = 25

    // MARK: Tracking State of Game
    var currBlocksPlaced = 0
    var currBlocksDropped = 0

    var isStarted = false
    var isGameEnded = false

    required init(eventMgr: EventManager) {
        self.eventMgr = eventMgr

        // Register all events that affect game state
        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
    }

    func update() {
        let gameState = getGameState()

        if gameState != .RUNNING && gameState != .PAUSED {
            eventMgr.postEvent(GameEndedEvent())
        }
    }

    func getGameState() -> Constants.GameState {
        if currBlocksPlaced >= blocksToPlace {
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

    func getScore() -> Int {
        max(realTimeTimer.count * scoreTimeLeftMultiplier
            + currBlocksPlaced * scoreBlocksPlacedMultiplier
            - currBlocksDropped * scoreBlocksDroppedMultiplier, 0)
    }

    func hasGameEnded() -> Bool {
        isGameEnded
    }

    func getTime() -> Int {
        realTimeTimer.count
    }

    func resetGame() {
        isStarted = false
        isGameEnded = false
        currBlocksPlaced = 0
        currBlocksDropped = 0
        realTimeTimer = GameTimer()
    }

    func startGame() {
        isStarted = true
        realTimeTimer.start(timeInSeconds: timeToPlaceBy, countsUp: false)
    }

    func endGame() {
        isGameEnded = true
        realTimeTimer.stop()
    }

    func getGameEndMainMessage() -> String {
        if getGameState() == .WIN {
            return Constants.defaultWinMainString
        } else if getGameState() == .LOSE {
            return Constants.defaultLoseMainString
        }

        return ""
    }

    func getGameEndSubMessage() -> String {
        if getGameState() == .WIN {
            return "You beat the clock!"
        } else if getGameState() == .LOSE {
            return "You ran out of time!."
        }

        return ""
    }

    private func blockPlaced(event: Event) {
        if let placedEvent = event as? BlockPlacedEvent {
            currBlocksPlaced = placedEvent.totalBlocksInLevel
        }
    }

    private func blockDropped(event: Event) {
        currBlocksDropped += 1
    }
}

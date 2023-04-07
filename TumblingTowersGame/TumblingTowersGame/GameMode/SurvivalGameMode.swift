//
//  SurvivalGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class SurvivalGameMode: GameMode {

    // Place N blocks wo dropping more than M blocks in shortest time possible (Score is time taken?)
    let blocksToPlace = 3
    let blocksDroppedThreshold = 1

    var currBlocksInserted = 0
    var currBlocksPlaced = 0
    var currBlocksDropped = 0

    var name = "Survival"

    var realTimeTimer = GameTimer()

    var isStarted = false
    var isGameEnded = false

    var eventMgr: EventManager

    required init(eventMgr: EventManager) {
        self.eventMgr = eventMgr

        // Register all events that affect game state

        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
        eventMgr.registerClosure(for: BlockInsertedEvent.self, closure: blockInserted)
    }

    func update() {
        let gameState = getGameState()

        if gameState != .RUNNING && gameState != .PAUSED {
            eventMgr.postEvent(GameEndedEvent())
        }
    }

    func getGameState() -> Constants.GameState {
//        print("Blocks Dropped \(currBlocksDropped)")
//        print("Blocks Placed \(currBlocksPlaced)")
//        print("Blocks Inserted \(currBlocksInserted)\n")

        if currBlocksDropped >= blocksDroppedThreshold {
            return .LOSE
        }

        if currBlocksPlaced >= blocksToPlace {
            return .WIN
        }

        if isStarted {
            return .RUNNING
        } else {
            return .NONE
        }
    }

    func hasGameEnded() -> Bool {
        isGameEnded
    }

    func getScore() -> Int {
        max(realTimeTimer.count - currBlocksDropped * 10, 0)
    }

    func getTime() -> Int {
        realTimeTimer.count
    }

    func resetGame() {
        isStarted = false
        isGameEnded = false
        currBlocksInserted = 0
        currBlocksPlaced = 0
        currBlocksDropped = 0
        realTimeTimer = GameTimer()
    }

    func startGame() {
        isStarted = true
        realTimeTimer.start(timeInSeconds: 0, countsUp: true)
    }

    func pauseGame() {
        realTimeTimer.pause()
    }

    func resumeGame() {
        realTimeTimer.resume()
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
            return "You stacked enough blocks!"
        } else if getGameState() == .LOSE {
            return "You dropped too many blocks!."
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

    private func blockInserted(event: Event) {
        currBlocksInserted += 1
    }
}

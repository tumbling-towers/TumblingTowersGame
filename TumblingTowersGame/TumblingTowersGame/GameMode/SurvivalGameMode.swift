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

    var isGameEnded = false

    var eventMgr: EventManager

    required init(eventMgr: EventManager) {
        // Register all events that affect game state

        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
        eventMgr.registerClosure(for: BlockInsertedEvent.self, closure: blockInserted)

        self.eventMgr = eventMgr
    }

    func update() {
        let gameState = getGameState()

        if gameState != .RUNNING && gameState != .PAUSED {
            endGame()
        }
    }

    func getGameState() -> Constants.GameState {
//        print("Blocks Dropped \(currBlocksDropped)")
//        print("Blocks Placed \(currBlocksPlaced)")
//        print("Blocks Inserted \(currBlocksInserted)\n")

        if currBlocksDropped >= blocksDroppedThreshold {
            isGameEnded = true
            endGame()

            // TODO: Post event
            return .LOSE
        }

        if currBlocksPlaced >= blocksToPlace {
            isGameEnded = true
            endGame()

            // Post event
            return .WIN
        }

        return .RUNNING
    }

    func hasGameEnded() -> Bool {
        isGameEnded
    }

    func getScore() -> Int {
        realTimeTimer.count - currBlocksDropped * 10
    }

    func getTime() -> Int {
        realTimeTimer.count
    }

    func resetGame() {
        isGameEnded = false
        currBlocksInserted = 0
        currBlocksPlaced = 0
        currBlocksDropped = 0
        realTimeTimer = GameTimer()
    }

    func startGame() {
        realTimeTimer.start(timeInSeconds: 0, countsUp: true)
    }

    func endGame() {
        isGameEnded = true
        realTimeTimer.stop()


    }

    func getGameEndMainMessage() -> String {
        if getGameState() == .WIN {
            return "Congratulations..."
        } else if getGameState() == .LOSE {
            return "You LOST!"
        }
    }

    func getGameEndSubMessage() -> String {
        if getGameState() == .WIN {
            return "You stacked enough blocks!"
        } else if getGameState() == .LOSE {
            return "You dropped too many blocks!."
        }
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

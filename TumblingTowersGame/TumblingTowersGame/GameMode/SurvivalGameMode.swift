//
//  SurvivalGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class SurvivalGameMode: GameMode {

    // Place N blocks wo dropping more than M blocks in shortest time possible (Score is time taken?)
    let blocksToPlace = 10
    let blocksDroppedThreshold = 5

    var currBlocksInserted = 0
    var currBlocksPlaced = 0
    var currBlocksDropped = 0

    var name = "Survival"

    var realTimeTimer = GameTimer()

    init(eventMgr: EventManager) {
        // Register all events that affect game state

        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
        eventMgr.registerClosure(for: BlockInsertedEvent.self, closure: blockInserted)
    }

    func getGameState() -> Constants.GameState {
        print("Blocks Dropped \(currBlocksDropped)")
        print("Blocks Placed \(currBlocksPlaced)")
        print("Blocks Inserted \(currBlocksInserted)\n")

        if currBlocksDropped >= blocksDroppedThreshold {
            return .LOSE_SURVIVAL
        }

        if currBlocksPlaced >= blocksToPlace {
            return .WIN_SURVIVAL
        }

        return .RUNNING
    }

    func getScore() -> Int {
        // TODO: Implement
        realTimeTimer.count - currBlocksDropped * 10
    }

    func getTimeRemaining() -> Float {
        // TODO: Implement
        Float(realTimeTimer.count)
    }

    func restartGame() {
        currBlocksInserted = 0
        currBlocksPlaced = 0
        currBlocksDropped = 0
        realTimeTimer = GameTimer()
    }

    func startTimer() {
        realTimeTimer.start(timeInSeconds: 0, countsUp: true)
    }

    func endTimer() {
        realTimeTimer.stop()
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

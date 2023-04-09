//
//  SurvivalGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class SurvivalGameMode: GameMode {
    let eventMgr: EventManager
    // Place N blocks wo dropping more than M blocks in shortest time possible (Score is time taken?)
    let blocksToPlace = 1
    let blocksDroppedThreshold = 1

    var currBlocksInserted = 0
    var currBlocksPlaced = 0
    var currBlocksDropped = 0

    var name = "Survival"

    var realTimeTimer = GameTimer()

    var isGameEnded = false

    required init(eventMgr: EventManager) {
        // Register all events that affect game state
        self.eventMgr = eventMgr
        
        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
        eventMgr.registerClosure(for: BlockInsertedEvent.self, closure: blockInserted)
    }

    func getGameState() -> Constants.GameState {
//        print("Blocks Dropped \(currBlocksDropped)")
//        print("Blocks Placed \(currBlocksPlaced)")
//        print("Blocks Inserted \(currBlocksInserted)\n")

        if currBlocksDropped >= blocksDroppedThreshold {
            isGameEnded = true
            endTimer()
            eventMgr.postEvent(GameEndedEvent())
            return .LOSE_SURVIVAL
        }

        if currBlocksPlaced >= blocksToPlace {
            isGameEnded = true
            endTimer()
            eventMgr.postEvent(GameEndedEvent())
            return .WIN_SURVIVAL
        }

        return .RUNNING
    }

    func hasGameEnded() -> Bool {
        isGameEnded
    }

    func getScore() -> Int {
        realTimeTimer.count - currBlocksDropped * 10
    }

    func getTimeRemaining() -> Int {
        realTimeTimer.count
    }

    func restartGame() {
        isGameEnded = false
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

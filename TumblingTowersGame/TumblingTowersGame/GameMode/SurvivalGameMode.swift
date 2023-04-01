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

    var currBlocksPlaced = 0
    var currBlocksDropped = 0

    var name = "Survival"

    var realTimeTimer = GameTimer()

    init(eventMgr: EventManager) {
        // Register all events that affect game state

        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
    }

    func getGameState() -> Constants.GameState {
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
        -realTimeTimer.count - currBlocksDropped * 10
    }

    func getTimeRemaining() -> Float {
        // TODO: Implement
        Float(-realTimeTimer.count)
    }

    func restartGame() {
        currBlocksPlaced = 0
        currBlocksDropped = 0
        realTimeTimer = GameTimer()
    }

    func startTimer() {
        realTimeTimer.start(timeInSeconds: 0)
    }

    func endTimer() {
        realTimeTimer.stop()
    }

    private func blockPlaced(event: Event) {
        currBlocksPlaced += 1
    }

    private func blockDropped(event: Event) {
        currBlocksDropped += 1
        currBlocksPlaced -= 1
    }

}

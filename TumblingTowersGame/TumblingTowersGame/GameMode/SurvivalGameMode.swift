//
//  SurvivalGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class SurvivalGameMode: GameMode {
    // Place N blocks wo dropping more than M blocks in shortest time possible (Score is time taken?)
    let blocksToPlace = 20
    let blocksDroppedThreshold = 5

    var currBlocksPlaced = 0
    var currBlocksDropped = 0

    var name = "Survival"

    init(eventMgr: EventManager) {
        // Register all events that affect game state

        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
    }

    func getGameState() -> Constants.GameState {
        if currBlocksDropped >= blocksDroppedThreshold {
            return .LOSE
        }

        if currBlocksPlaced >= blocksToPlace {
            return .WIN
        }

        return .RUNNING
    }

    func getScore() -> Int {
        // TODO: Implement
        1
    }

    func getTimeRemaining() -> Float {
        // TODO: Implement
        2
    }

    func restartGame() {
        currBlocksPlaced = 0
        currBlocksDropped = 0
    }

    private func blockPlaced(event: Event) {
        currBlocksPlaced += 1
    }

    private func blockDropped(event: Event) {
        currBlocksDropped += 1
    }

}

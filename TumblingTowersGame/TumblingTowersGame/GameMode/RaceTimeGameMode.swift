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

    let blocksToPlace = 10
    let timeToPlaceBy = 15

    var currBlocksPlaced = 0

    init(eventMgr: EventManager) {
        // Register all events that affect game state
        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
    }


    func getGameState() -> Constants.GameState {
        if currBlocksPlaced >= blocksToPlace {
            return .WIN_RACE
        } else if realTimeTimer.count < 0 {
            return .LOSE_RACE
        }

        return .RUNNING
    }


    func getScore() -> Int {
        realTimeTimer.count
    }

    func getTimeRemaining() -> Float {
        Float(realTimeTimer.count)
    }

    func restartGame() {
        currBlocksPlaced = 0
        realTimeTimer = GameTimer()
    }

    func startTimer() {
        realTimeTimer.start(timeInSeconds: timeToPlaceBy, countsUp: false)
    }

    func endTimer() {
        realTimeTimer.stop()
    }

    private func blockPlaced(event: Event) {
        currBlocksPlaced += 1
    }

    private func blockDropped(event: Event) {
        currBlocksPlaced -= 1
    }
}

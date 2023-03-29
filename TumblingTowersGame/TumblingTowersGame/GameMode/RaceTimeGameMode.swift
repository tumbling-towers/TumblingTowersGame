//
//  RaceTimeGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class RaceTimeGameMode: GameMode {

    var name = "Race Against the Clock"

    init(eventMgr: EventManager) {
        // Register all events that affect game state

    }


    func getGameState() -> Constants.GameState {
        .RUNNING
    }


    func getScore() -> Int {
        0
    }

    func getTimeRemaining() -> Float {
        0
    }

    func restartGame() {

    }


}

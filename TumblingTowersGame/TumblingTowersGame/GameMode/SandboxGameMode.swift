//
//  SandboxGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 2/4/23.
//

import Foundation

class SandboxGameMode: GameMode {

    var name = "Sandbox"

    var realTimeTimer = GameTimer()

    var isGameEnded = false

    init(eventMgr: EventManager) {

    }


    func getGameState() -> Constants.GameState {
        return .RUNNING
    }


    func getScore() -> Int {
        realTimeTimer.count
    }

    func hasGameEnded() -> Bool {
        isGameEnded
    }

    func getTimeRemaining() -> Int {
        realTimeTimer.count
    }

    func restartGame() {
        isGameEnded = false
        realTimeTimer = GameTimer()
    }

    func startTimer() {
        realTimeTimer.start(timeInSeconds: 0, countsUp: true)
    }

    func endTimer() {
        realTimeTimer.stop()
    }
}

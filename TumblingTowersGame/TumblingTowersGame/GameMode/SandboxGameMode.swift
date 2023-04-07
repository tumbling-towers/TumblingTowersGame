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

    var eventMgr: EventManager

    required init(eventMgr: EventManager) {
        self.eventMgr = eventMgr
    }

    func update() {
        let gameState = getGameState()

        if gameState != .RUNNING && gameState != .PAUSED {
            endGame()
        }
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

    func getTime() -> Int {
        realTimeTimer.count
    }

    func resetGame() {
        isGameEnded = false
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
        "Thank you for playing!"
    }

    func getGameEndSubMessage() -> String {
        "Please Try Again!"
    }
}

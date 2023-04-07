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

    var isStarted = false
    var isGameEnded = false

    var eventMgr: EventManager

    required init(eventMgr: EventManager) {
        self.eventMgr = eventMgr
    }

    func update() {
        let gameState = getGameState()

        if gameState != .RUNNING && gameState != .PAUSED {
            eventMgr.postEvent(GameEndedEvent())
        }
    }

    func getGameState() -> Constants.GameState {
        if isStarted {
            return .RUNNING
        } else {
            return .NONE
        }
    }

    func getScore() -> Int {
        0
    }

    func hasGameEnded() -> Bool {
        isGameEnded
    }

    func getTime() -> Int {
        realTimeTimer.count
    }

    func resetGame() {
        isStarted = false
        isGameEnded = false
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
        "Thank you for playing!"
    }

    func getGameEndSubMessage() -> String {
        "Please Try Again!"
    }
}

//
//  MockGameMode.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 16/4/23.
//

import Foundation

class MockGameMode: GameMode {
    static var name: String = "MOCKGAMEMODE"
    
    static var description: String = "MOCKGAMEMODE_DESCRIPTION"
    
    var isUpdated = false
    
    var isGameStarted = false
    
    var isGamePaused = false
    
    var isGameReset = false
    
    required init(eventMgr: EventManager, playerId: UUID, levelHeight: CGFloat) {
    }
    
    func update() {
        isUpdated = true
    }
    
    var gameState: Constants.GameState = .RUNNING
    
    var isGameEnded: Bool = false
    
    var score: Int = 0
    
    var time: Int = 0
    
    var gameEndMainMessage: String = "MOCKGAMEMODE_ENDMAINMESSAGE"
    
    var gameEndSubMessage: String = "MOCKGAMEMODE_ENDSUBMESSAGE"
    
    func startGame() {
        isGameStarted = true
    }
    
    func pauseGame() {
        isGamePaused = true
    }
    
    func resumeGame() {
        isGamePaused = false
    }
    
    func resetGame() {
        isGameReset = true
    }
    
    func endGame(endedBy: UUID, endState: Constants.GameState) {
        isGameEnded = true
    }
    
    
}

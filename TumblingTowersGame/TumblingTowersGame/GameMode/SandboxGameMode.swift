//
//  SandboxGameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 2/4/23.
//

import Foundation

class SandboxGameMode: GameMode {

    static var name = Constants.GameModeTypes.SANDBOX.rawValue
    static var description = "A chill, infinite game mode for you to do anything you want. Get creative!"

    var realTimeTimer = GameTimer()
    var eventMgr: EventManager

    // MARK: Constants for this game mode
    let scoreBlocksPlacedMultiplier = 10
    let scoreBlocksDroppedMultiplier = 25
    
    // MARK: Tracking State of Game
    var currBlocksPlaced = 0
    var currBlocksDropped = 0
    let playerId: UUID

    var isStarted = false
    var isGameEnded = false

    required init(eventMgr: EventManager, playerId: UUID, levelHeight: CGFloat) {
        self.eventMgr = eventMgr
        self.playerId = playerId

        // Register all events that affect game state
        eventMgr.registerClosure(for: BlockPlacedEvent.self, closure: blockPlaced)
        eventMgr.registerClosure(for: BlockDroppedEvent.self, closure: blockDropped)
    }

    func update() {
        if gameState != .RUNNING && gameState != .PAUSED {
            eventMgr.postEvent(GameEndedEvent(playerId: playerId, endState: gameState))
        }
    }

    var gameState: Constants.GameState {
        if isStarted {
            return .RUNNING
        } else {
            return .NONE
        }
    }

    var score: Int {
        max(currBlocksPlaced * scoreBlocksPlacedMultiplier
        - currBlocksDropped * scoreBlocksDroppedMultiplier, 0)
    }

    var time: Int {
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

    func endGame(endedBy: UUID, endState: Constants.GameState) {
        isGameEnded = true
        realTimeTimer.stop()
    }

    var gameEndMainMessage: String {
        "Thank you for playing!"
    }

    var gameEndSubMessage: String {
        "Please Try Again!"
    }

    private func blockPlaced(event: Event) {
        if let placedEvent = event as? BlockPlacedEvent, placedEvent.playerId == playerId {
            currBlocksPlaced = placedEvent.totalBlocksInLevel
        }
    }

    private func blockDropped(event: Event) {
        if let droppedEvent = event as? BlockDroppedEvent, droppedEvent.playerId == playerId {
            currBlocksDropped += 1
        }
    }

}

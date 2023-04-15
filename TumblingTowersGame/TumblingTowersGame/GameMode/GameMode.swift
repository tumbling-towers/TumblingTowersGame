//
//  GameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

protocol GameMode {

    static var name: String { get }

    static var description: String { get }

    init(eventMgr: EventManager, playerId: UUID, levelHeight: CGFloat)

    func update()

    var gameState: Constants.GameState { get }

    var isGameEnded: Bool { get }

    var score: Int { get }

    var time: Int { get }

    var gameEndMainMessage: String { get }

    var gameEndSubMessage: String { get }

    func startGame()

    func pauseGame()

    func resumeGame()

    func resetGame()

    func endGame(endedBy: UUID, endState: Constants.GameState)
}

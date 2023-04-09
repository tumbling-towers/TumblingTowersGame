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

    init(eventMgr: EventManager)

    func getGameState() -> Constants.GameState

    func hasGameEnded() -> Bool

    func getScore() -> Int

    func getTime() -> Int

    func startGame()

    func pauseGame()

    func resumeGame()

    func resetGame()

    func endGame()

    func getGameEndMainMessage() -> String

    func getGameEndSubMessage() -> String

    func update()
}

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

    // FIXME: can this be a computed variable?
    func getGameState() -> Constants.GameState

    // FIXME: can this be a computed variable?
    func hasGameEnded() -> Bool

    // FIXME: can this be a computed variable?
    func getScore() -> Int

    // FIXME: can this be a computed variable?
    func getTime() -> Int

    func startGame()

    func pauseGame()

    func resumeGame()

    func resetGame()

    func endGame(endedBy: UUID, endState: Constants.GameState)

    // FIXME: can this be a computed variable?
    func getGameEndMainMessage() -> String

    // FIXME: can this be a computed variable?
    func getGameEndSubMessage() -> String

    func update()
}

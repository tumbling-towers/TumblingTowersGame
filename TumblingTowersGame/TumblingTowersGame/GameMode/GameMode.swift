//
//  GameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

protocol GameMode {

    var name: String { get }

    init(eventMgr: EventManager)

    func getGameState() -> Constants.GameState

    func hasGameEnded() -> Bool

    func getScore() -> Int

    func getTimeRemaining() -> Int

    func restartGame()

    func startTimer()

    func endTimer()
}

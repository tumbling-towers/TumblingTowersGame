//
//  GameMode.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

protocol GameMode {

    var name: String { get }

    func getGameState() -> Constants.GameState

    func getScore() -> Int

    func getTimeRemaining() -> Float

    func restartGame()

    func startTimer()

    func endTimer()
}

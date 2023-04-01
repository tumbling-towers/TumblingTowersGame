//
//  PowerupManager.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

protocol PowerupManager: PowerupDelegate {
    var eventManager: EventManager? { get set }
    var rng: RandomNumberGeneratorWithSeed { get }
    var nextPowerup: Powerup? { get set }
    func createNextPowerup() -> Void
    func activateNextPowerup() -> Void
}

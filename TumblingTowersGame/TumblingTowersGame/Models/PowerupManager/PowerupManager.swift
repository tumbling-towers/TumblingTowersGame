//
//  PowerupManager.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

protocol PowerupManager: AnyObject {
    var eventManager: EventManager { get set }
    var gameWorld: GameWorld { get set }
    var rng: RandomNumberGeneratorWithSeed { get }
    var availablePowerups: [Powerup?] { get set }
    func createNextPowerup()
    func activatePowerup(at idx: Int)
}

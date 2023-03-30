//
//  PowerupManager.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

protocol PowerupManager: PowerupDelegate {
    var eventManager: EventManager? { get set }
    var powerupQueue: Queue<Powerup> { get set }
    var rng: RandomNumberGeneratorWithSeed { get }
    
    func activateNextPowerup() -> Void
}

extension PowerupManager {
    mutating func activateNextPowerup() {
        let nextPowerup = powerupQueue.dequeue()
        nextPowerup?.activate()
    }
}


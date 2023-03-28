//
//  GamePowerupManager.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

class GamePowerupManager: PowerupManager {
    static let defaultNumPowerups = 10
    
    static let powerupTypes: [Powerup.Type] = [VinePowerup.self, PlatformPowerup.self]
    
    var eventManager: EventManager?
    
    var powerupQueue: Queue<Powerup>
    
    var rng: RandomNumberGeneratorWithSeed
    
    init(eventManager: EventManager? = nil, powerupQueue: Queue<Powerup>, seed: Int) {
        self.eventManager = eventManager
        self.powerupQueue = powerupQueue
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
    }
    
    func activateNextPowerup() {
        
    }
    
    func didActivateVinePowerup() {
        eventManager?.postEvent(VinePowerupActivatedEvent())
    }
    
    func didActivatePlatformPowerup() {
        eventManager?.postEvent(PlatformPowerupActivatedEvent())
    }
    
    func populatePowerupQueue() {
        for _ in 0..<GamePowerupManager.defaultNumPowerups {
            let idx = Int(rng.next()) % GamePowerupManager.powerupTypes.count
            let powerup = GamePowerupManager.powerupTypes[idx]
            do {
                try powerupQueue.enqueue(powerup.create())
            } catch {
                // TODO: do nothing?
            }
        }
    }
}

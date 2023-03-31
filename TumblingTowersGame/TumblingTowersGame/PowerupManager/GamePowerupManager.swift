//
//  GamePowerupManager.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

class GamePowerupManager: PowerupManager {
    static let defaultNumPowerups = 10
    
    static let powerupTypes: [Powerup.Type] = [GluePowerup.self, PlatformPowerup.self]
    
    var eventManager: EventManager? {
        didSet {
            registerEvents()
        }
    }
    
    var rng: RandomNumberGeneratorWithSeed
    
    var nextPowerup: Powerup?
    
    init(eventManager: EventManager? = nil, seed: Int) {
        self.eventManager = eventManager
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
    }
    
    func activateNextPowerup() {
        nextPowerup?.activate()
        nextPowerup = nil
    }
    
    func createNextPowerup() {
        let idx = Int(rng.next()) % GamePowerupManager.powerupTypes.count
        let type = GamePowerupManager.powerupTypes[idx]
        
        nextPowerup = type.create()
        eventManager?.postEvent(PowerupAvailableEvent(type: type))
    }
    
    func didActivateGluePowerup() {
        eventManager?.postEvent(GluePowerupActivatedEvent())
    }
    
    func didActivatePlatformPowerup() {
        eventManager?.postEvent(PlatformPowerupActivatedEvent())
    }
    
    private func registerEvents() {
        // remove the powerup when it is used
        eventManager?.registerClosure(for: PowerupActivatedEvent.self, closure: { event in
            print("inside powerup manager, powerup has been used")
            self.nextPowerup = nil
        })
    }
}

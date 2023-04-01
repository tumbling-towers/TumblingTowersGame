//
//  GamePowerupManager.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

class GamePowerupManager: PowerupManager {
    static let defaultNumPowerups = 10
    
    static let powerupTypes: [Powerup.Type] = [PlatformPowerup.self, GluePowerup.self]
    
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
        // TODO: Why does it only generate even numbers?
        let next = rng.next() / 1000
        let idx = Int(next) % GamePowerupManager.powerupTypes.count
        let type = GamePowerupManager.powerupTypes[idx]
        
        nextPowerup = type.create()
        nextPowerup?.delegate = self
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
        eventManager?.registerClosure(for: PowerupButtonTappedEvent.self, closure: { event in
            self.activateNextPowerup()
        })
    }
}

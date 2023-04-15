//
//  GamePowerupManager.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation
import CoreGraphics

class GamePowerupManager: PowerupManager {
    var gameWorld: GameWorld
    
    static let defaultNumPowerups = 10

    static let powerupTypes: [Powerup.Type] = [PlatformPowerup.self, GluePowerup.self]

    var eventManager: EventManager

    var rng: RandomNumberGeneratorWithSeed

    var availablePowerups: [Powerup?] = [Powerup?](repeating: nil,
                                                   count: GameWorldConstants.maxPowerupsAtOneTime)

    init(eventManager: EventManager, gameWorld: GameWorld, seed: Int) {
        self.eventManager = eventManager
        self.gameWorld = gameWorld
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
        
        registerEvents()
    }

    func activatePowerup(at idx: Int) {
        availablePowerups[idx]?.activate()
        availablePowerups[idx] = nil
    }

    func createNextPowerup() {
        // TODO: Why does it only generate even numbers?
        let next = rng.next() / 1_000
        let idx = Int(next) % GamePowerupManager.powerupTypes.count
        let type = GamePowerupManager.powerupTypes[idx]
        
        if let index = availablePowerups.firstIndex(where: { $0 == nil }) {
            let nextPowerup = type.create(manager: self)
            availablePowerups[index] = nextPowerup
            eventManager.postEvent(PowerupAvailableEvent(type: type, idx: index, for: gameWorld))
        }
    }

    private func registerEvents() {
        // remove the powerup when it is used
        eventManager.registerClosure(for: PowerupButtonTappedEvent.self, closure: { event in
            if let event = event as? PowerupButtonTappedEvent, event.gameWorld === self.gameWorld {
                self.activatePowerup(at: event.idx)
            }
        })
    }
}

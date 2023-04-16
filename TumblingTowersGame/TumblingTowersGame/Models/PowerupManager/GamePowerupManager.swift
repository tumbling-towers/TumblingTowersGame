//
//  GamePowerupManager.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation
import CoreGraphics

class GamePowerupManager: PowerupManager {

    // This is needed to avoid strong reference cycle to GameWorld
    private weak var actualGameWorld: GameWorld?

    var gameWorld: GameWorld? {
        get {
            actualGameWorld
        }
        set {
            actualGameWorld = newValue
        }
    }
    
    static let defaultNumPowerups = 10

    static let powerupTypes: [Powerup.Type] = [PlatformPowerup.self, GluePowerup.self]

    var eventManager: EventManager

    var rng: RandomNumberGeneratorWithSeed

    var availablePowerups: [Powerup?] = [Powerup?](repeating: nil,
                                                   count: GameWorldConstants.maxPowerupsAtOneTime)

    init(eventManager: EventManager, gameWorld: GameWorld, seed: Int) {
        self.eventManager = eventManager
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
        self.gameWorld = gameWorld
        registerEvents()
    }

    func activatePowerup(at idx: Int) {
        availablePowerups[idx]?.activate()
        availablePowerups[idx] = nil
    }

    func createNextPowerup() {
        let next = rng.next() / 1_000
        let idx = Int(next) % GamePowerupManager.powerupTypes.count
        let type = GamePowerupManager.powerupTypes[idx]
        
        if let index = availablePowerups.firstIndex(where: { $0 == nil }) {
            let nextPowerup = type.create(manager: self)
            availablePowerups[index] = nextPowerup
            if let gameWorld = gameWorld {
                eventManager.postEvent(PowerupAvailableEvent(type: type, idx: index, for: gameWorld))
            }
        }
    }

    private func registerEvents() {
        eventManager.registerClosure(for: PowerupButtonTappedEvent.self, closure: powerupButtonTappedEventFired)
    }

    private lazy var powerupButtonTappedEventFired = { [weak self] (_ event: Event) -> Void in
        if let event = event as? PowerupButtonTappedEvent, event.gameWorld === self?.gameWorld {
            self?.activatePowerup(at: event.idx)
        }
    }
    
}

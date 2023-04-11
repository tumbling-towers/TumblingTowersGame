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

    // FIXME: count here is a magic number
    var availablePowerups: [Powerup?] = [Powerup?](repeating: nil, count: 5)

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
            var nextPowerup = type.create()
            nextPowerup.delegate = self
            availablePowerups[index] = nextPowerup
            eventManager.postEvent(PowerupAvailableEvent(type: type, idx: index))
        }
    }

    func didActivateGluePowerup() {
        gameWorld.currentlyMovingBlock?.specialProperties.isGlue = true
        eventManager.postEvent(GluePowerupActivatedEvent())
    }

    func didActivatePlatformPowerup() {
        guard let newPlatform = createPowerupPlatform() else { return }
        gameWorld.addObject(object: newPlatform)
        eventManager.postEvent(PlatformPowerupActivatedEvent())
    }
    
    // FIXME: a lil too long, try to pull out private functions?
    func createPowerupPlatform() -> Platform? {
        guard let platform = gameWorld.level.mainPlatform else { return nil }
        var count = 0
        while count < GameWorldConstants.defaultTriesToFindPlatformPosition {
            let rngX = Int(rng.next()) % Int(platform.width)
            let newX = CGFloat(rngX) + platform.position.x - platform.width / 2
            var newY = gameWorld.highestPoint + GameWorldConstants.bufferFromHighestPoint
            if let powerupLine = gameWorld.level.powerupLine {
                newY = min(newY, powerupLine.position.y - GameWorldConstants.defaultPowerupPlatformHeight)
            }
            let newPosition = CGPoint(x: newX, y: newY)
            let rect = CGRect(x: newPosition.x,
                              y: newPosition.y,
                              width: GameWorldConstants.defaultPowerupPlatformWidth,
                              height: GameWorldConstants.defaultPowerupPlatformHeight)
            let path = CGPath.create(from: rect)
            let shape = GamePathObjectShape(path: path)

            guard let newPlatform: Platform = GameWorldObjectFactory.create(ofType: .platform,
                                                                                     ofShape: shape,
                                                                                           at: newPosition) else {
                // TODO: throw error
                assert(false)
                return nil
            }

            let otherBodies = gameWorld.level.gameObjects.map({ $0.fiziksBody })

            if !gameWorld.fiziksEngine.isIntersecting(body: newPlatform.fiziksBody, otherBodies: otherBodies) {
                return newPlatform
            }

            count += 1
        }

        return nil
    }

    private func registerEvents() {
        // remove the powerup when it is used
        eventManager.registerClosure(for: PowerupButtonTappedEvent.self, closure: { event in
            if let event = event as? PowerupButtonTappedEvent {
                self.activatePowerup(at: event.idx)
            }
            
        })
    }
}

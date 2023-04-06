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

    var nextPowerup: Powerup?

    init(eventManager: EventManager, gameWorld: GameWorld, seed: Int) {
        self.eventManager = eventManager
        self.gameWorld = gameWorld
        self.rng = RandomNumberGeneratorWithSeed(seed: seed)
        
        registerEvents()
    }

    func activateNextPowerup() {
        nextPowerup?.activate()
        nextPowerup = nil
    }

    func createNextPowerup() {
        // TODO: Why does it only generate even numbers?
        let next = rng.next() / 1_000
        let idx = Int(next) % GamePowerupManager.powerupTypes.count
        let type = GamePowerupManager.powerupTypes[idx]

        nextPowerup = type.create()
        nextPowerup?.delegate = self
        eventManager.postEvent(PowerupAvailableEvent(type: type))
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
    
    func createPowerupPlatform() -> Platform? {
        guard let platform = gameWorld.level.platform else { return nil }
        var count = 0
        while count < GameWorldConstants.defaultTriesToFindPlatformPosition {
            let rngX = Int(rng.next()) % Int(platform.width)
            let newX = CGFloat(rngX) + platform.position.x - platform.width / 2
            var newY = gameWorld.findHighestPoint() + GameWorldConstants.bufferFromHighestPoint
            if let powerupLine = gameWorld.level.powerupLine {
                newY = min(newY, powerupLine.position.y - GameWorldConstants.defaultPowerupPlatformHeight)
            }
            let newPosition = CGPoint(x: newX, y: newY)
            let rect = CGRect(x: newPosition.x,
                              y: newPosition.y,
                              width: GameWorldConstants.defaultPowerupPlatformWidth,
                              height: GameWorldConstants.defaultPowerupPlatformHeight)
            let path = CGPath.create(from: rect)

            let newPlatform = gameWorld.createPlatform(path: path, at: newPosition)

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
        eventManager.registerClosure(for: PowerupButtonTappedEvent.self, closure: { _ in
            self.activateNextPowerup()
        })
    }
}

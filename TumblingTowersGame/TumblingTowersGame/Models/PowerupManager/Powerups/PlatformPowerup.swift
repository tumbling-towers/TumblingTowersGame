//
//  PlatformPowerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation
import CoreGraphics

class PlatformPowerup: Powerup {
    // This is needed to avoid strong reference cycle to PowerupManager
    private weak var realManager: PowerupManager?

    var manager: PowerupManager? {
        get {
            realManager
        }
        set {
            realManager = newValue
        }
    }

    private var gameWorld: GameWorld? {
        manager?.gameWorld
    }
    
    private var eventManager: EventManager? {
        manager?.eventManager
    }
    
    private var rng: RandomNumberGeneratorWithSeed? {
        manager?.rng
    }

    static var type: PowerupType = .platform
    
    init(manager: PowerupManager) {
        self.manager = manager
    }

    static func create(manager: PowerupManager) -> Powerup {
        PlatformPowerup(manager: manager)
    }

    func activate() {
        guard let newPlatform = createPowerupPlatform() else { return }
        gameWorld?.addObject(object: newPlatform)
        eventManager?.postEvent(PlatformPowerupActivatedEvent())
    }
    
    func createPowerupPlatform() -> Platform? {
        guard let platform = manager?.gameWorld?.level.mainPlatform else { return nil }
        guard let gameWorld = gameWorld else { return nil }
        guard let rng = rng else { return nil }
        
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
    
}

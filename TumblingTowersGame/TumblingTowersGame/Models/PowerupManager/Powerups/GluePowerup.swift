//
//  GluePowerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

// FIXME: reminder, logic of each powerup should be moved here, GameWorld should expose an API thats reasonably general (e.g. turnIntoGlue(Block))
class GluePowerup: Powerup {
    var manager: PowerupManager
    
    private var gameWorld: GameWorld {
        manager.gameWorld
    }
    
    private var eventManager: EventManager {
        manager.eventManager
    }

    static var type: PowerupType = .glue
    
    init(manager: PowerupManager) {
        self.manager = manager
    }

    static func create(manager: PowerupManager) -> Powerup {
        GluePowerup(manager: manager)
    }

    func activate() {
        let newProperties = SpecialProperties(isGlueBlock: true)
        gameWorld.setCMBSpecialProperties(properties: newProperties)
        eventManager.postEvent(GluePowerupActivatedEvent())
    }
}

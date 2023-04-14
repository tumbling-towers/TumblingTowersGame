//
//  PowerupAvailableEvent.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 31/3/23.
//

import Foundation

class PowerupAvailableEvent: TumblingTowersEvent {
    let gameWorld: GameWorld
    let type: Powerup.Type
    let idx: Int

    init(type: Powerup.Type, idx: Int, for gameWorld: GameWorld) {
        self.type = type
        self.idx = idx
        self.gameWorld = gameWorld
    }
}

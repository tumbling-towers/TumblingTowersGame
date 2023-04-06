//
//  PowerupAvailableEvent.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 31/3/23.
//

import Foundation

class PowerupAvailableEvent: TumblingTowersEvent {
    let type: Powerup.Type
    let idx: Int

    init(type: Powerup.Type, idx: Int) {
        self.type = type
        self.idx = idx
    }
}

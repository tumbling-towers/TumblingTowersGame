//
//  PowerupButtonTappedEvent.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 31/3/23.
//

import Foundation

class PowerupButtonTappedEvent: TumblingTowersEvent {
    let type: Powerup.Type

    init(type: Powerup.Type) {
        self.type = type
    }
}

//
//  PowerupButtonTappedEvent.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 31/3/23.
//

import Foundation

class PowerupButtonTappedEvent: TumblingTowersEvent {
    let idx: Int
    let gameWorld: GameWorld

    init(idx: Int, for gameWorld: GameWorld) {
        self.idx = idx
        self.gameWorld = gameWorld
    }
}

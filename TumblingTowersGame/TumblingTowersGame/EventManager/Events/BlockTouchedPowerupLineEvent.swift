//
//  BlockTouchedPowerupLineEvent.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 5/4/23.
//

import Foundation

class BlockTouchedPowerupLineEvent: TumblingTowersEvent {
    let playerId: UUID

    init(playerId: UUID) {
        self.playerId = playerId
    }
}

//
//  BlockPlacedEvent.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 27/3/23.
//

import Foundation

class BlockPlacedEvent: TumblingTowersEvent {
    let totalBlocksInLevel: Int
    let playerId: UUID

    init(totalBlocksInLevel: Int, playerId: UUID) {
        self.totalBlocksInLevel = totalBlocksInLevel
        self.playerId = playerId
    }
}

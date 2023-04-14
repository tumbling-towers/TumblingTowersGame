//
//  BlockDroppedEvent.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import Foundation

class BlockDroppedEvent: TumblingTowersEvent {
    let playerId: UUID

    init(playerId: UUID) {
        self.playerId = playerId
    }
}

//
//  BlockInsertedEvent.swift
//  TumblingTowersGame
//
//  Created by Elvis on 2/4/23.
//

import Foundation

class BlockInsertedEvent: TumblingTowersEvent {
    let playerId: UUID

    init(playerId: UUID) {
        self.playerId = playerId
    }
}

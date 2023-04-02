//
//  BlockPlacedEvent.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 27/3/23.
//

import Foundation

class BlockPlacedEvent: TumblingTowersEvent {
    let totalBlocksInLevel: Int

    init(totalBlocksInLevel: Int) {
        self.totalBlocksInLevel = totalBlocksInLevel
    }
}

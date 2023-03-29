//
//  NumBlocksPlacedAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class NumBlocksPlacedStatTracker: StatTracker {
    var numBlocksPlaced: Int
    
    init(eventManager: EventManager) {
        self.numBlocksPlaced = 0
        eventManager.registerClosure(for: BlockPlacedEvent.self, closure: { [weak self] (event: Event) in
            self?.numBlocksPlaced += 1
        })
    }
}

//
//  NumBlocksPlacedAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class NumBlocksPlacedStatTracker: StatTracker {
    var stat: Double
    var statTrackerType: StatTrackerType = .numBlocksPlaced
    
    init(eventManager: EventManager, stat: Double? = 0) {
        self.stat = stat ?? 0
        eventManager.registerClosure(for: BlockPlacedEvent.self, closure: blockPlacedClosure)
    }
    
    private lazy var blockPlacedClosure = { [weak self] (_ event: Event) -> Void in
        self?.stat = (self?.stat as? Double ?? 0) + 1
    }
}

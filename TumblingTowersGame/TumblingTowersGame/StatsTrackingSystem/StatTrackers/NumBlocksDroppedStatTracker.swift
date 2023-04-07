//
//  NumBlocksDroppedStatTracker.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class NumBlocksDroppedStatTracker: StatTracker {
    var stat: Any
    let statTrackerType: StatTrackerType = .numBlocksDropped
    
    init(eventManager: EventManager, stat: Any? = 0) {
        self.stat = stat ?? 0
        eventManager.registerClosure(for: BlockDroppedEvent.self, closure: blockDroppedClosure)
    }
    
    private lazy var blockDroppedClosure = { [weak self] (_ event: Event) -> Void in
        self?.stat = (self?.stat as? Int ?? 0) + 1
    }
}

//
//  NumBlocksDroppedStatTracker.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class NumBlocksDroppedStatTracker: StatTracker {
    static let name: String = "NumBlocksLost"
    var numBlocksDropped: Int
    
    init(eventManager: EventManager) {
        self.numBlocksDropped = 0
        eventManager.registerClosure(for: BlockDroppedEvent.self, closure: blockDroppedClosure)
    }
    
    private lazy var blockDroppedClosure = { [weak self] (_ event: Event) -> Void in
        self?.numBlocksDropped += 1
    }
}

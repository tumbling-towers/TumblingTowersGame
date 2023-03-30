//
//  NumBlocksPlacedAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class NumBlocksPlacedStatTracker: StatTracker {
    static let name: String = "NumBlocksPlaced"
    var numBlocksPlaced: Int
    
    init(eventManager: EventManager) {
        self.numBlocksPlaced = 0
        eventManager.registerClosure(for: BlockPlacedEvent.self, closure: blockPlacedClosure)
    }
    
    private lazy var blockPlacedClosure = { [weak self] (_ event: Event) -> Void in
        self?.numBlocksPlaced += 1
    }
}

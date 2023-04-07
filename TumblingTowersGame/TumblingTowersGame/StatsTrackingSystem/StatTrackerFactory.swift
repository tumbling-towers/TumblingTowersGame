//
//  StatTrackerFactory.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 7/4/23.
//

import Foundation

class StatTrackerFactory {
    static func createStatTracker(ofType statTrackerType: StatTrackerType, eventManager: EventManager, stat: Any? = nil) -> StatTracker {
        switch statTrackerType {
        case .numBlocksPlaced:
            return NumBlocksPlacedStatTracker(eventManager: eventManager, stat: stat)
        case .numBlocksDropped:
            return NumBlocksDroppedStatTracker(eventManager: eventManager, stat: stat)
        case .towerHeight:
            return TowerHeightStatTracker(eventManager: eventManager, stat: stat)
        }
    }
}

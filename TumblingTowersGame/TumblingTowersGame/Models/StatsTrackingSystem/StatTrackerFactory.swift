//
//  StatTrackerFactory.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 7/4/23.
//

import Foundation

class StatTrackerFactory {
    static let statTrackerTypeToStatTracker: [String: StatTracker.Type] = [StatTrackerType.numBlocksPlaced.rawValue:
                                                                            NumBlocksPlacedStatTracker.self,
                                                                           StatTrackerType.numBlocksDropped.rawValue:
                                                                            NumBlocksDroppedStatTracker.self,
                                                                           StatTrackerType.towerHeight.rawValue:
                                                                            TowerHeightStatTracker.self]

    static func getStatTrackerFromStatTrackerType(from: StatTrackerType) -> StatTracker.Type? {
        statTrackerTypeToStatTracker[from.rawValue]
    }

    static func createStatTracker(ofType statTrackerType: StatTrackerType, eventManager: EventManager, stat: Double? = nil) -> StatTracker {
        guard let statTrackerClass = getStatTrackerFromStatTrackerType(from: statTrackerType) else {
            assert(false)
        }

        return statTrackerClass.init(eventManager: eventManager, stat: stat)
    }
}

//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

class StatsTrackingSystem {
    let eventManager: EventManager
    // TODO: consider which one to keep. array or map?
    var statTrackers: [StatTracker]
    var statTrackerMap: [String: StatTracker]
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        self.statTrackers = []
        self.statTrackerMap = [:]
        setupStatTrackers()
    }
    
    private func setupStatTrackers() {
        // TODO: get from storage
        add(NumBlocksPlacedStatTracker(eventManager: eventManager))
        add(NumBlocksLostStatTracker(eventManager: eventManager))
    }
    
    private func add(_ statTracker: StatTracker) {
        statTrackers.append(statTracker)
        statTrackerMap[type(of: statTracker).name] = statTracker
    }
}

extension StatsTrackingSystem: BobTheBuilderAchievementDataSource {
    var numBlocksPlaced: Int? {
        let tracker = statTrackerMap[NumBlocksPlacedStatTracker.name] as? NumBlocksPlacedStatTracker
        return tracker?.numBlocksPlaced
    }
    
    var numBlocksDropped: Int? {
        let tracker = statTrackerMap[NumBlocksLostStatTracker.name] as? NumBlocksLostStatTracker
        return tracker?.numBlocksLost
    }
}

extension StatsTrackingSystem: AchievementSystemDataSource {
}

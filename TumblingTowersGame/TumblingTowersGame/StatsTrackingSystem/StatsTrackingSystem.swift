//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

class StatsTrackingSystem {
    let eventManager: EventManager
    var statTrackerMap: [String: StatTracker]
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        self.statTrackerMap = [:]
        setupStatTrackers()
    }
    
    private func setupStatTrackers() {
        // TODO: get from storage
        add(NumBlocksPlacedStatTracker(eventManager: eventManager))
        add(NumBlocksDroppedStatTracker(eventManager: eventManager))
        add(TowerHeightStatTracker(eventManager: eventManager))
    }
    
    private func add(_ statTracker: StatTracker) {
        statTrackerMap[type(of: statTracker).name] = statTracker
    }
}

extension StatsTrackingSystem: AchievementSystemDataSource {}

extension StatsTrackingSystem: BobTheBuilderAchievementDataSource {
    var numBlocksPlaced: Int? {
        let tracker = statTrackerMap[NumBlocksPlacedStatTracker.name] as? NumBlocksPlacedStatTracker
        return tracker?.numBlocksPlaced
    }
    
    var numBlocksDropped: Int? {
        let tracker = statTrackerMap[NumBlocksDroppedStatTracker.name] as? NumBlocksDroppedStatTracker
        return tracker?.numBlocksDropped
    }
}

extension StatsTrackingSystem: SkyscraperAchievementDataSource {
    var towerHeight: CGFloat? {
        let tracker = statTrackerMap[TowerHeightStatTracker.name] as? TowerHeightStatTracker
        return tracker?.height
    }
}

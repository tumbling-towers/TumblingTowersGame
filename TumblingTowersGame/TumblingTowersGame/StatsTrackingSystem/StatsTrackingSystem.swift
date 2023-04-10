//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

class StatsTrackingSystem {
    let eventManager: EventManager
    var statTrackerTypeToStatTracker: [StatTrackerType: StatTracker]
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        self.statTrackerTypeToStatTracker = [:]
        setupStatTrackers()
    }
    
    private func setupStatTrackers() {
        // TODO: get from storage
        // Info that needs to be stored:
        // * stat tracker type (enum type)
        // * stat (Any type i think best to store as string)
        // Then can use the factory to make the stat tracker (note factory has an extra optional parameter `stat` that can take in the stored stat
        // TODO: as for saving to storage, maybe can listen for some event e.g. GameEndedEvent then call the save method
        add(StatTrackerFactory.createStatTracker(ofType: .numBlocksPlaced, eventManager: eventManager))
        add(StatTrackerFactory.createStatTracker(ofType: .numBlocksDropped, eventManager: eventManager))
        add(StatTrackerFactory.createStatTracker(ofType: .towerHeight, eventManager: eventManager))
    }
    
    private func add(_ statTracker: StatTracker) {
        statTrackerTypeToStatTracker[statTracker.statTrackerType] = statTracker
    }
}

extension StatsTrackingSystem: AchievementSystemDataSource {
    func getStat(for statTrackerType: StatTrackerType) -> Any? {
        guard let statTracker = statTrackerTypeToStatTracker[statTrackerType] else {
            return nil
        }
        return statTracker.stat
    }
}


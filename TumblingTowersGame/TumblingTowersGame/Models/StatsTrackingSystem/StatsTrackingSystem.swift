//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

class StatsTrackingSystem {
    let eventManager: EventManager
    var statTrackers: [StatTracker]
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        self.statTrackers = []
        setupStatTrackers()
    }
    
    private func setupStatTrackers() {
        // TODO: get from storage
        add(NumBlocksPlacedStatTracker(eventManager: eventManager))
        add(NumBlocksLostStatTracker(eventManager: eventManager))
    }
    
    private func add(_ statTracker: StatTracker) {
        statTrackers.append(statTracker)
    }
}

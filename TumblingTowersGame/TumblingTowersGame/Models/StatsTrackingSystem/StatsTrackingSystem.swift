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
    private let storageManager: StorageManager

    init(eventManager: EventManager, storageManager: StorageManager) {
        self.eventManager = eventManager
        self.statTrackerTypeToStatTracker = [:]
        self.storageManager = storageManager

        setupStatTrackers()
        eventManager.registerClosure(for: GameEndedEvent.self, closure: saveStats)
    }

    private lazy var saveStats = { [weak self] (_ event: Event) -> Void in
        guard let values = self?.statTrackerTypeToStatTracker.values else {
            return
        }

        let statTrackers = Array(values)
        try? self?.storageManager.saveStats(statTrackers)
    }

    private func setupStatTrackers() {
        guard let statsStorage = try? storageManager.loadStats(eventManager: eventManager) else {
            return
        }

        if statsStorage.count == .zero {
            loadDefaultStats()
        } else {
            loadStorageStats(statsStorage: statsStorage)
        }
    }

    private func loadDefaultStats() {
        for statTrackerType in StatTrackerType.allCases {
            add(StatTrackerFactory.createStatTracker(ofType: statTrackerType, eventManager: eventManager))
        }
    }

    private func loadStorageStats(statsStorage: [StatTracker]) {
        for storage in statsStorage {
            add(storage)
        }
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

//
//  StorageManager.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 2/4/23.
//

import Foundation

class StorageManager {
    static let settingsFileName = "settings"
    static let achievementsFileName = "achievements"
    static let statsFileName = "stats"

    let storageFacade = StorageFacade()

    func saveSettings(_ settings: [Float]) throws {
        try storageFacade.save(floats: settings, fileName: StorageManager.settingsFileName)
    }

    func loadSettings() throws -> [Float] {
        let settings = try storageFacade.loadFloats(fileName: StorageManager.settingsFileName)
        return settings
    }

    func saveAchievements(_ achievements: [any Achievement]) throws {
        var achievementsStorage: [AchievementStorage] = []
        for achievement in achievements {
            achievementsStorage.append(AchievementStorage(achievement))
        }

        try storageFacade.save(achievements: achievementsStorage, fileName: StorageManager.achievementsFileName)
    }

    func loadAchievements(dataSource: AchievementSystemDataSource) throws -> [any Achievement] {
        let achievementStorages = try storageFacade.loadAchievements(fileName: StorageManager.achievementsFileName)

        var achievements: [any Achievement] = []
        for achievementStorage in achievementStorages {
            let achievement = AchievementFactory.createAchievement(ofType: achievementStorage.achievementType,
                                                                   name: achievementStorage.name,
                                                                   goal: achievementStorage.goal,
                                                                   achieved: achievementStorage.achieved,
                                                                   dataSource: dataSource)
            achievements.append(achievement)
        }
        return achievements
    }

    func resetAchievements() {
        try? storageFacade.delete(fileName: StorageManager.achievementsFileName)
        try? storageFacade.delete(fileName: StorageManager.statsFileName)
    }

    func saveStats(_ statTrackers: [StatTracker]) throws {
        var statsStorage: [StatStorage] = []
        for statTracker in statTrackers {
            statsStorage.append(StatStorage(statTracker))
        }

        try storageFacade.save(statStorages: statsStorage, fileName: StorageManager.statsFileName)
    }

    func loadStats(eventManager: EventManager) throws -> [any StatTracker] {
        let statStorages = try storageFacade.loadStatStorages(fileName: StorageManager.statsFileName)

        var stats: [StatTracker] = []
        for storage in statStorages {
            let stat = StatTrackerFactory.createStatTracker(ofType: storage.statTrackerType,
                                                            eventManager: eventManager,
                                                            stat: storage.stat)
            stats.append(stat)
        }

        return stats
    }
}

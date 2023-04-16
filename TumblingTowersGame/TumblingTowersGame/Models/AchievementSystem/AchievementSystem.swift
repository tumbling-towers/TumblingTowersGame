//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class AchievementSystem {
    private var achievements: [any Achievement]
    private let dataSource: AchievementSystemDataSource
    private let storageManager: StorageManager

    init(eventManager: EventManager, dataSource: AchievementSystemDataSource, storageManager: StorageManager) {
        self.achievements = []
        self.dataSource = dataSource
        self.storageManager = storageManager
        setupAchievements()
    }

    func calculateAndGetUpdatedAchievements() -> [any Achievement] {
        updateAllAchievements()
        return achievements
    }

    private func setupAchievements() {
        guard let achievementsStorage = try? storageManager.loadAchievements(dataSource: dataSource) else {
            return
        }

        if achievementsStorage.count == .zero {
            loadDefaultAchievements()
        } else {
            loadStorageAchievements(achievementsStorage: achievementsStorage)
        }
    }

    private func loadDefaultAchievements() {
        add(AchievementFactory.createAchievement(ofType: .bobTheBuilder,
                                                 name: "BobTheBuilder I",
                                                 goal: 2,
                                                 achieved: false,
                                                 dataSource: dataSource))
        add(AchievementFactory.createAchievement(ofType: .bobTheBuilder,
                                                 name: "BobTheBuilder II",
                                                 goal: 20,
                                                 achieved: false,
                                                 dataSource: dataSource))
        add(AchievementFactory.createAchievement(ofType: .skyscraper,
                                                 name: "SkyScraper I",
                                                 goal: 300,
                                                 achieved: false,
                                                 dataSource: dataSource))
        add(AchievementFactory.createAchievement(ofType: .skyscraper,
                                                 name: "SkyScraper II",
                                                 goal: 500,
                                                 achieved: false,
                                                 dataSource: dataSource))
    }

    private func loadStorageAchievements(achievementsStorage: [any Achievement]) {
        for achievementStorage in achievementsStorage {
            add(achievementStorage)
        }
    }

    private func add(_ achievement: any Achievement) {
        achievements.append(achievement)
    }

    private func updateAllAchievements() {
        for achievement in achievements {
            achievement.update()
        }
        try? storageManager.saveAchievements(achievements)
    }
}

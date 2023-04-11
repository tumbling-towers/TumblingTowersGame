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
    
    /// This method is used for to get the most updated list of achievements.
    func getUpdatedAchievements() -> [any Achievement] {
        updateAllAchievements()
        return achievements
    }
    
    private func setupAchievements() {
        guard let achievementsStorage = try? storageManager.loadAchievements() else {
            return
        }
        
        if achievementsStorage.count == 0 {
            loadDefaultAchievements()
            return
        }
        
        for achievementStorage in achievementsStorage {
            add(AchievementFactory.createAchievement(ofType: achievementStorage.achievementType,
                                                     name: achievementStorage.name,
                                                     goal: achievementStorage.goal,
                                                     achieved: achievementStorage.achieved,
                                                     dataSource: dataSource))
        }
    }
    
    private func loadDefaultAchievements() {
        add(AchievementFactory.createAchievement(ofType: .BobTheBuilder,
                                                 name: "BobTheBuilder I",
                                                 goal: 2,
                                                 achieved: false,
                                                 dataSource: dataSource))
        add(AchievementFactory.createAchievement(ofType: .BobTheBuilder,
                                                 name: "BobTheBuilder II",
                                                 goal: 20,
                                                 achieved: false,
                                                 dataSource: dataSource))
        add(AchievementFactory.createAchievement(ofType: .Skyscraper,
                                                 name: "SkyScraper I",
                                                 goal: 300,
                                                 achieved: false,
                                                 dataSource: dataSource))
        add(AchievementFactory.createAchievement(ofType: .Skyscraper,
                                                 name: "SkyScraper II",
                                                 goal: 500,
                                                 achieved: false,
                                                 dataSource: dataSource))
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

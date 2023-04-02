//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class AchievementSystem {
    private var achievements: [Achievement]
    private let dataSource: AchievementSystemDataSource
    
    init(eventManager: EventManager, dataSource: AchievementSystemDataSource) {
        self.achievements = []
        self.dataSource = dataSource
        setupAchievements()
    }
    
    /// This method is used for to get the most updated list of achievements.
    func getUpdatedAchievements() -> [Achievement] {
        updateAllAchievements()
        return achievements
    }
    
    private func setupAchievements() {
        add(BobTheBuilderAchievement(name: "BobTheBuilder I", goal: 2, dataSource: dataSource))
        add(BobTheBuilderAchievement(name: "BobTheBuilder II", goal: 20, dataSource: dataSource))
        add(BobTheBuilderAchievement(name: "BobTheBuilder III", goal: 50, dataSource: dataSource))
        add(SkyscraperAchievement(name: "Skyscraper I", goal: 300, dataSource: dataSource))
        add(SkyscraperAchievement(name: "Skyscraper II", goal: 8000, dataSource: dataSource))
        add(SkyscraperAchievement(name: "Skyscraper III", goal: 1500, dataSource: dataSource))
    }
    
    private func add(_ achievement: Achievement) {
        achievements.append(achievement)
    }
    
    private func updateAllAchievements() {
        for achievement in achievements {
            achievement.update()
        }
    }
}

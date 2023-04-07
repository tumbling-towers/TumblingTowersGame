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
        // TODO: get from storage
        // Info that needs to be stored:
        // * achievement type (enum type)
        // * goal (Any type, i think best to store as string)
        // * name
        // * achieved (bool)
        // Then can use the factory to make the achievement
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
                                                 goal: 8000,
                                                 achieved: false,
                                                 dataSource: dataSource))
    }
    
    private func add(_ achievement: Achievement) {
        achievements.append(achievement)
    }
    
    private func updateAllAchievements() {
        for achievement in achievements {
            achievement.update()
        }
        // TODO: I think this is a good place to call a saveToStorage method
    }
}

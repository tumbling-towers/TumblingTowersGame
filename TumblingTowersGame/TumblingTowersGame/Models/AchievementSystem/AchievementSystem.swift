//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class AchievementSystem {
    var achievements: [Achievement]
    let achievementSystemDataSource: AchievementSystemDataSource
    
    init(eventManager: EventManager, dataSource: AchievementSystemDataSource) {
        self.achievements = []
        self.achievementSystemDataSource = dataSource
        eventManager.registerClosure(for: GameEndedEvent.self, closure: { [weak self] (event: Event) in
            self?.updateAllAchievements()
        })
        setupAchievements()
    }
    
    private func setupAchievements() {
        add(BobTheBuilderAchievement(dataSource: achievementSystemDataSource))
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

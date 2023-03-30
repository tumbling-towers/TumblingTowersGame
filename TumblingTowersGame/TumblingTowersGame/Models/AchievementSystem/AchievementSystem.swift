//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class AchievementSystem {
    var achievements: [Achievement]
    let dataSource: AchievementSystemDataSource
    
    init(eventManager: EventManager, dataSource: AchievementSystemDataSource) {
        self.achievements = []
        self.dataSource = dataSource
        eventManager.registerClosure(for: GameEndedEvent.self, closure: { [weak self] (event: Event) in
            self?.updateAllAchievements()
        })
        setupAchievements()
    }
    
    private func setupAchievements() {
        add(BobTheBuilderAchievement(name: "BobTheBuilder I", goal: 10, dataSource: dataSource))
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

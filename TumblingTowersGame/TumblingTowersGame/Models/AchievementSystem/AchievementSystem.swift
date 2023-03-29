//
//  AchievementSystem.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

class AchievementSystem {
    let eventManager: EventManager
    var achievements: [Achievement]
    
    init(eventManager: EventManager) {
        self.eventManager = eventManager
        self.achievements = []
        setupAchievements()
    }
    
    private func setupAchievements() {
        // TODO: get from storage
        add(BlockPlacerAchievement(eventManager: eventManager))
    }
    
    private func add(_ achievement: Achievement) {
        achievements.append(achievement)
    }
}

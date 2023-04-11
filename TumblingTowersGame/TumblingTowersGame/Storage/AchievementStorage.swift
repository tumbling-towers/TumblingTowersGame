//
//  AchievementStorage.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 8/4/23.
//

import Foundation

struct AchievementStorage: Codable {
    var name: String
    var description: String
    var goal: Double
    var achieved: Bool
    var achievementType: AchievementType
    
    init(name: String, description: String, goal: Double, achieved: Bool, achievementType: AchievementType) {
        self.name = name
        self.description = description
        self.goal = goal
        self.achieved = achieved
        self.achievementType = achievementType
    }
    
    init(_ achievement: Achievement) {
        self.name = achievement.name
        self.description = achievement.description
        self.goal = achievement.goal
        self.achieved = achievement.achieved
        self.achievementType = achievement.achievementType
    }
}


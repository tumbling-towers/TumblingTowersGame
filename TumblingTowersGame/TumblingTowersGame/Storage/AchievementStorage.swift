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
    var goal: AnyCodable
    var achieved: Bool
    var achievementType: AchievementType
    
    init(name: String, description: String, goal: AnyCodable, achieved: Bool, achievementType: AchievementType) {
        self.name = name
        self.description = description
        self.goal = goal
        self.achieved = achieved
        self.achievementType = achievementType
    }
    
    init(_ achievement: Achievement) {
        self.name = achievement.name
        self.description = achievement.description
        self.goal = try! AnyCodable(with: achievement.goal)
        self.achieved = achievement.achieved
        self.achievementType = achievement.achievementType
    }
}


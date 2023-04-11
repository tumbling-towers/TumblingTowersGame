//
//  SkyscraperAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 30/3/23.
//

import Foundation

class SkyscraperAchievement: Achievement {
    var name: String
    var description: String {
        "Build a tower \(goal)m high.\nHighest tower: \(highScore.truncate(places: 1))m"
    }
    let goal: Double
    var achieved: Bool {
        highScore >= goal
    }
    let achievementType: AchievementType = .Skyscraper
    let dataSource: AchievementSystemDataSource
    
    var highScore: Double {
        didSet {
            highScore = min(goal, highScore)
        }
    }
    
    init(name: String, goal: Double, dataSource: AchievementSystemDataSource) {
        self.name = name
        self.goal = goal
        self.dataSource = dataSource
        self.highScore = 0
    }
    
    func update() {
        guard let newHeight = dataSource.getStat(for: .towerHeight) as? Double else {
            return
        }
        highScore = max(highScore, newHeight)
    }
}

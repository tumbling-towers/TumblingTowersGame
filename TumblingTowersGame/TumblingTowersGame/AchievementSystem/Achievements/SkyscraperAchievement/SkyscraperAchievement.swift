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
        "Build a tower 10m high. Highest tower: \(highScore)"
    }
    var achieved: Bool {
        highScore >= goal
    }
    
    let dataSource: SkyscraperAchievementDataSource
    var highScore: CGFloat
    let goal: CGFloat
    
    init(name: String, goal: CGFloat, dataSource: SkyscraperAchievementDataSource) {
        self.name = name
        self.goal = goal
        self.dataSource = dataSource
        self.highScore = 0
    }
    
    func update() {
        guard let height = dataSource.towerHeight else {
            return
        }
        highScore = max(highScore, height)
    }
}

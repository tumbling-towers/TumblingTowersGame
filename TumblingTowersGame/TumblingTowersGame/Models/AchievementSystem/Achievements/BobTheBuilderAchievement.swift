//
//  BobTheBuilderAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class BobTheBuilderAchievement: Achievement {
    var name: String
    var description: String {
        "Place \(goal) blocks without them falling off the platform.\nProgress: \(Int(progress))/\(Int(goal))"
    }
    let goal: Double
    var achieved: Bool {
        progress >= goal
    }
    let achievementType: AchievementType = .BobTheBuilder
    let dataSource: AchievementSystemDataSource
    
    var progress: Double {
        didSet {
            progress = min(goal, progress)
        }
    }
    
    required init(name: String, goal: Double, dataSource: AchievementSystemDataSource) {
        self.name = name
        self.goal = goal
        self.dataSource = dataSource
        self.progress = 0
    }
    
    func update() {
        guard let numBlocksPlaced = dataSource.getStat(for: .numBlocksPlaced) as? Double,
              let numBlocksDropped = dataSource.getStat(for: .numBlocksDropped) as? Double else {
            return
        }
        progress = (numBlocksPlaced - numBlocksDropped)
    }
}

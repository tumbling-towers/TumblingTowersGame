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
        "Place \(goal) blocks without them falling off the platform. Progress: \(progress)/\(goal)"
    }
    let goal: Any
    var achieved: Bool {
        progress >= (goal as? Int ?? 0)
    }
    let achievementType: AchievementType = .BobTheBuilder
    let dataSource: AchievementSystemDataSource
    
    var progress: Int
    
    init(name: String, goal: Any, dataSource: AchievementSystemDataSource) {
        self.name = name
        self.goal = goal
        self.dataSource = dataSource
        self.progress = 0
    }
    
    func update() {
        guard let numBlocksPlaced = dataSource.getStat(for: .numBlocksPlaced) as? Int,
              let numBlocksDropped = dataSource.getStat(for: .numBlocksDropped) as? Int else {
            return
        }
        progress = (numBlocksPlaced - numBlocksDropped)
    }
}

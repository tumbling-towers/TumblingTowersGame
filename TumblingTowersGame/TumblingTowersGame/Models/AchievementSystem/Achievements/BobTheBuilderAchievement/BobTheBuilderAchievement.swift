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
    var achieved: Bool {
        progress >= goal
    }
    
    let dataSource: BobTheBuilderAchievementDataSource
    var progress: Int
    let goal: Int
    
    init(name: String, goal: Int, dataSource: BobTheBuilderAchievementDataSource) {
        self.name = name
        self.goal = goal
        self.dataSource = dataSource
        self.progress = 0
    }
    
    func update() {
        guard let numBlocksPlaced = dataSource.numBlocksPlaced,
              let numBlocksDropped = dataSource.numBlocksDropped else {
            return
        }
        progress = (numBlocksPlaced - numBlocksDropped)
    }
}

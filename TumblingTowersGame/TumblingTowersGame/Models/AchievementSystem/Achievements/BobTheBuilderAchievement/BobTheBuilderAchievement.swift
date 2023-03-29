//
//  BobTheBuilderAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

class BobTheBuilderAchievement: Achievement {
    var name: String {
        "BobTheBuilder(\(goal))"
    }
    var achieved: Bool
    
    let dataSource: BobTheBuilderAchievementDataSource
    let goal: Int
    
    init(dataSource: BobTheBuilderAchievementDataSource, achieved: Bool = false, goal: Int = 10) {
        self.dataSource = dataSource
        self.achieved = achieved
        self.goal = goal
    }
    
    func update() {
        guard let numBlocksPlaced = dataSource.numBlocksPlaced,
              let numBlocksDropped = dataSource.numBlocksDropped else {
            return
        }
        achieved = (numBlocksPlaced - numBlocksDropped) >= goal
    }
}

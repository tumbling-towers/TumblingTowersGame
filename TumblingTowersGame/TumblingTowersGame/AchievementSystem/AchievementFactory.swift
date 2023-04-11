//
//  AchievementFactory.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 7/4/23.
//

import Foundation

class AchievementFactory {
    static func createAchievement(ofType achievementType: AchievementType,
                                  name: String,
                                  goal: Double,
                                  achieved: Bool,
                                  dataSource: AchievementSystemDataSource) -> any Achievement {
        switch achievementType {
        case .BobTheBuilder:
            return BobTheBuilderAchievement(name: name, goal: goal, dataSource: dataSource)
        case .Skyscraper:
            return SkyscraperAchievement(name: name, goal: goal, dataSource: dataSource)
        }
    }
}

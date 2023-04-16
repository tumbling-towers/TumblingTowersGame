//
//  AchievementFactory.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 7/4/23.
//

import Foundation

class AchievementFactory {
    private static let achievementTypeToAchievement: [String: any Achievement.Type] =
        [AchievementType.bobTheBuilder.rawValue: BobTheBuilderAchievement.self,
         AchievementType.skyscraper.rawValue: SkyscraperAchievement.self]

    private static func getAchievementFromAchievementType(from: AchievementType) -> (any Achievement.Type)? {
        achievementTypeToAchievement[from.rawValue]
    }

    static func createAchievement(ofType achievementType: AchievementType,
                                  name: String,
                                  goal: Double,
                                  achieved: Bool,
                                  dataSource: AchievementSystemDataSource) -> any Achievement {
        guard let achievementClass = getAchievementFromAchievementType(from: achievementType) else {
            assert(false)
        }

        return achievementClass.init(name: name, goal: goal, dataSource: dataSource)
    }
}

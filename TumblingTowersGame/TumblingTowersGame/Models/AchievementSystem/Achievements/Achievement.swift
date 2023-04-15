//
//  Achievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

protocol Achievement: Identifiable {
    var name: String { get }
    var description: String { get }
    var goal: Double { get }
    var achieved: Bool { get }
    var achievementType: AchievementType { get }
    var dataSource: AchievementSystemDataSource { get }

    init(name: String, goal: Double, dataSource: AchievementSystemDataSource)
    func update()
}

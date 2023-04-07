//
//  Achievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

protocol Achievement {
    var name: String { get }
    var description: String { get }
    var goal: Any { get }
    var achieved: Bool { get }
    var achievementType: AchievementType { get }
    var dataSource: AchievementSystemDataSource { get }
    func update()
}

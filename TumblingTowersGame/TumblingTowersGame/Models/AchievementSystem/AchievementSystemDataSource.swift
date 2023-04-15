//
//  AchievementSystemDataSource.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

protocol AchievementSystemDataSource {
    func getStat(for statTrackerType: StatTrackerType) -> Any?
}

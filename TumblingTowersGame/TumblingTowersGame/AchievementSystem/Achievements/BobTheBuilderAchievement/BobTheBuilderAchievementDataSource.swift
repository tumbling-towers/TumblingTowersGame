//
//  BobTheBuilderAchievementDataSource.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 29/3/23.
//

import Foundation

protocol BobTheBuilderAchievementDataSource {
    var numBlocksPlaced: Int? { get }
    var numBlocksDropped: Int? { get }
}

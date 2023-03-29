//
//  Achievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

protocol Achievement {
    var name: String { get }
    var achievementDescription: String { get }
    var progressDescription: String { get }
}

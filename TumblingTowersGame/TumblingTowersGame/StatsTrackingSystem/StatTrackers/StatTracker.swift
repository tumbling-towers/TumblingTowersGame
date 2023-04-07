//
//  Achievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

protocol StatTracker {
    var stat: Any { get }
    var statTrackerType: StatTrackerType { get }
}

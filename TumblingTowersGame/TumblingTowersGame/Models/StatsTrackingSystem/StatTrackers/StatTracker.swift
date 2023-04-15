//
//  Achievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

protocol StatTracker {

    init(eventManager: EventManager, stat: Double?)

    var stat: Double { get }
    var statTrackerType: StatTrackerType { get }
}

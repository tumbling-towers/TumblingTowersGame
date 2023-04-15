//
//  StatStorage.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 9/4/23.
//

import Foundation

class StatStorage: Codable {
    var stat: Double
    var statTrackerType: StatTrackerType
    
    init(stat: Double, statTrackerType: StatTrackerType) {
        self.stat = stat
        self.statTrackerType = statTrackerType
    }
    
    init(_ statTracker: StatTracker) {
        self.stat = statTracker.stat
        self.statTrackerType = statTracker.statTrackerType
    }
}

extension StatStorage: CustomStringConvertible {
    var description: String {
        "stat \(stat) type \(statTrackerType)"
    }
}

//
//  PerGameAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

class CountPerGameAchievement: Achievement {
    let name: String
    let achievementDescription: String
    var triggeringEvent: Event
    
    var bestScore: Int
    var currentScore: Int
    var goal: Int
    
    init(name: String,
         achievementDescription: String,
         triggeringEvent: Event,
         bestScore: Int = 0,
         currentScore: Int = 0,
         goal: Int) {
        self.name = name
        self.achievementDescription = achievementDescription
        self.triggeringEvent = triggeringEvent
        self.bestScore = bestScore
        self.currentScore = currentScore
        self.goal = goal
    }
    
    func trigger() {
    }
}

extension CountPerGameAchievement: CustomStringConvertible {
    var description: String {
        "Ended a game with more than {goal} "
    }
}

//
//  DisplayableAchievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 10/4/23.
//

import Foundation

struct DisplayableAchievement: Identifiable {
    var id: UUID
    var name: String
    var description: String
    var goal: Any
    var achieved: Bool
}

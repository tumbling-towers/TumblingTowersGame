//
//  Achievement.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 28/3/23.
//

import Foundation

protocol Achievement: CustomStringConvertible {
    var name: String { get }
    var achievementDescription: String { get }
    var triggeringEvent: Event { get set }
    
    func trigger()
}

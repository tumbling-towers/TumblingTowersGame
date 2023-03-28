//
//  PowerupFactory.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

class PowerupFactory{
    static func create(type: PowerupType) -> Powerup? {
        switch type {
        case .vines:
            return VinePowerup()
        case .platform:
            return PlatformPowerup()
        default:
            return nil
        }
    }
}

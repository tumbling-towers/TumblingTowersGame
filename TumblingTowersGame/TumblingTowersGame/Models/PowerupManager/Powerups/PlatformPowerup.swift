//
//  PlatformPowerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

// FIXME: off the top of my head, GameWorld can expose add(platform: Platform, at position: CGPoint)
class PlatformPowerup: Powerup {
    var delegate: PowerupDelegate?

    static var type: PowerupType = .platform

    static func create() -> Powerup {
        PlatformPowerup()
    }

    func activate() {
        delegate?.didActivatePlatformPowerup()
    }
}

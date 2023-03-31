//
//  PlatformPowerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

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

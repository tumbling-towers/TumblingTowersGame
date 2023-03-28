//
//  VinePowerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

class VinePowerup: Powerup {
    var delegate: PowerupDelegate?
    
    static func create() -> Powerup {
        VinePowerup()
    }
    
    func activate() {
        delegate?.didActivateVinePowerup()
    }
}

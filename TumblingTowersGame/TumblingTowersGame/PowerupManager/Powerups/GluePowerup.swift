//
//  GluePowerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

class GluePowerup: Powerup {
    var delegate: PowerupDelegate?
    
    static var type: PowerupType = .glue
    
    static func create() -> Powerup {
        GluePowerup()
    }
    
    func activate() {
        delegate?.didActivateGluePowerup()
    }
}

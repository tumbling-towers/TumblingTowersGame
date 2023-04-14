//
//  GluePowerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

// FIXME: reminder, logic of each powerup should be moved here, GameWorld should expose an API thats reasonably general (e.g. turnIntoGlue(Block))
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

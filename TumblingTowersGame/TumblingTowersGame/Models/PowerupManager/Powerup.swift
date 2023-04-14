//
//  Powerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

protocol Powerup {
    var manager: PowerupManager { get set }
    static var type: PowerupType { get }

    // FIXME: Good use of factory pattern. DOCUMENT!!!
    static func create(manager: PowerupManager) -> Powerup

    func activate()
}

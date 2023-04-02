//
//  Powerup.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 28/3/23.
//

import Foundation

protocol Powerup {
    var delegate: PowerupDelegate? { get set }
    static var type: PowerupType { get }

    static func create() -> Powerup

    func activate()
}

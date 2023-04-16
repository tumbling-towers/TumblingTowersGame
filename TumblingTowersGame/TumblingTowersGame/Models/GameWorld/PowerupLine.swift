//
//  PowerupLine.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 5/4/23.
//

import Foundation

class PowerupLine {
    var position: CGPoint
    var dimensions: CGRect

    init(position: CGPoint, dimensions: CGRect) {
        self.position = position
        self.dimensions = dimensions
    }
}

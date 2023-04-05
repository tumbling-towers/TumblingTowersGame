//
//  PowerupLineShape.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 27/3/23.
//

import Foundation
import CoreGraphics

struct PowerupLineShape: PathObjectShape {
    var height: Double {
        path.height
    }

    var width: Double {
        path.width
    }

    var path: CGPath

    init(path: CGPath) {
        self.path = path
    }
}

//
//  PlatformShape.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import Foundation
import CoreGraphics

struct PlatformShape: PathObjectShape {
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

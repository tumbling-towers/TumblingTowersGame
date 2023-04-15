//
//  GamePathObjectShape.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 9/4/23.
//

import Foundation
import CoreGraphics

struct GamePathObjectShape: PathObjectShape {
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

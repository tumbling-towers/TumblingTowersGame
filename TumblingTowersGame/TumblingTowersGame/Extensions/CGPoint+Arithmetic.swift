//
//  CGPoint+Arithmetic.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 24/3/23.
//

import Foundation
import CoreGraphics

extension CGPoint {
    func add(by vector: CGVector) -> CGPoint {
        CGPoint(x: self.x + vector.dx, y: self.y + vector.dy)
    }

    func subtract(by vector: CGVector) -> CGPoint {
        CGPoint(x: self.x - vector.dx, y: self.y - vector.dy)
    }
}

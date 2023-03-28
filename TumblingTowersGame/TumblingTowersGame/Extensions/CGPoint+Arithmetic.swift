//
//  CGPoint+Arithmetic.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 24/3/23.
//

import Foundation
import CoreGraphics

extension CGPoint {
    func add(by otherPoint: CGPoint) -> CGPoint {
        CGPoint(x: self.x + otherPoint.x, y: self.y + otherPoint.y)
    }

    func subtract(by otherPoint: CGPoint) -> CGPoint {
        CGPoint(x: self.x - otherPoint.x, y: self.y - otherPoint.y)
    }
}

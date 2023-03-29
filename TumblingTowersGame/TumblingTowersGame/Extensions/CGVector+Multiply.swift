//
//  CGVector+Multiply.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 29/3/23.
//

import Foundation

extension CGVector {
    static func * (firstOp: CGVector, multiplier: Double) -> CGVector {
        CGVector(dx: firstOp.dx * multiplier, dy: firstOp.dy * multiplier)
    }
}

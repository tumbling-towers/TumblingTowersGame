//
//  GameObjectCategory.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 9/3/23.
//

import Foundation
typealias BitMask = UInt32

struct CategoryMask {
    static let none: BitMask = 0
    static let block: BitMask = 0x1 << 0
    static let platform: BitMask = 0x1 << 1
    static let powerupLine: BitMask = 0x1 << 2
    static let levelBoundary: BitMask = 0x1 << 3
    static let max: BitMask = 0xFFFFFFFF
}

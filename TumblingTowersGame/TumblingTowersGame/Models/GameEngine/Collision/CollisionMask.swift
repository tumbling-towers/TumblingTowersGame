//
//  GameCollision.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 16/3/23.
//

import Foundation

struct CollisionMask {
    static let none: BitMask = 0
    static let block: BitMask = CategoryMask.block | CategoryMask.platform
    static let platform: BitMask = CategoryMask.platform | CategoryMask.block
    static let levelBoundary: BitMask = CategoryMask.levelBoundary | CategoryMask.block
    static let fallingBlock: BitMask = CollisionMask.block | CategoryMask.levelBoundary
    static let max: BitMask = 0xFFFFFFFF
}

//
//  GameCollision.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 16/3/23.
//

import Foundation

struct CollisionMask {
    static let none: BitMask = 0
    
    static let fallingBlock: BitMask = CategoryMask.block | CategoryMask.platform | CategoryMask.levelBoundary
    static let block: BitMask = CollisionMask.fallingBlock ^ CategoryMask.levelBoundary

    static let platform: BitMask = CategoryMask.platform | CategoryMask.block
    static let levelBoundary: BitMask = CategoryMask.levelBoundary | CategoryMask.block
    static let max: BitMask = 0xFFFFFFFF
}

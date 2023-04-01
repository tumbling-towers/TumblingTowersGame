//
//  ContactTestMask.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 16/3/23.
//

import Foundation

// TODO: Update/add more
struct ContactTestMask {
    static let none: BitMask = 0

    // only interested in contact with powerup line when block has landed
    static let fallingBlock: BitMask = CategoryMask.block | CategoryMask.platform
    static let block: BitMask = ContactTestMask.block | ContactTestMask.powerupLine

    static let powerupLine = CategoryMask.powerupLine
    static let platform: BitMask = CategoryMask.platform | CategoryMask.block
    static let max: BitMask = 0xFFFFFFFF
}

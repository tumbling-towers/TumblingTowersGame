//
//  ContactTestMask.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 16/3/23.
//

import Foundation

struct ContactTestMask {
    static let none: BitMask = 0

    static let fallingBlock: BitMask = CategoryMask.block | CategoryMask.platform
    static let block: BitMask = ContactTestMask.block | ContactTestMask.powerupLine

    static let powerupLine = CategoryMask.powerupLine
    static let platform: BitMask = CategoryMask.platform | CategoryMask.block
    static let max: BitMask = 0xFFFFFFFF
}

//
//  GameObjectCategory.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 9/3/23.
//

import Foundation
typealias BitMask = UInt32

enum GameObjectCategory {
    case none,
         block,
         platform,
         max

    static let categoryToBitMaskMap: [GameObjectCategory: BitMask] =
        [none: 0,
         block: 0x1 << 0,
         platform: 0x1 << 1,
         max: 0xFFFFFFFF]

    static let categoryToCollisionBitMaskMap: [GameObjectCategory: BitMask] =
        [none: 0,
         block: block.categoryBitMask | platform.categoryBitMask,
         max: 0xFFFFFFFF]

    var categoryBitMask: BitMask {
        GameObjectCategory.categoryToBitMaskMap[self] ?? 0
    }

    var collisionBitMask: BitMask {
        GameObjectCategory.categoryToCollisionBitMaskMap[self] ?? 0
    }

    var contactTestBitMask: BitMask {
        0
    }
}

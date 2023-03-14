//
//  GameObject.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 8/3/23.
//

import Foundation

protocol GameObject: FiziksBody {
    var category: GameObjectCategory { get }
}

extension GameObject {
    var categoryBitMask: BitMask {
        category.categoryBitMask
    }

    var collisionBitMask: BitMask {
        category.collisionBitMask
    }

    var contactTestBitMask: BitMask {
        category.contactTestBitMask
    }
}

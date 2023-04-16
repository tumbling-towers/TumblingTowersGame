//
//  LevelBoundary.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 9/4/23.
//

import Foundation
import Fiziks

class LevelBoundary: GameWorldObject {

    let fiziksBody: FiziksBody

    var shape: ObjectShape

    var rotation: Double {
        fiziksBody.zRotation
    }

    var specialProperties: SpecialProperties

    static var categoryBitMask: BitMask = CategoryMask.platform

    static var collisionBitMask: BitMask = CollisionMask.platform

    static var contactTestBitMask: BitMask = ContactTestMask.platform

    init(fiziksBody: FiziksBody, shape: ObjectShape, specialProperties: SpecialProperties = SpecialProperties()) {
        self.fiziksBody = fiziksBody
        self.shape = shape
        self.specialProperties = specialProperties
    }
}

extension LevelBoundary: Equatable {
    static func == (lhs: LevelBoundary, rhs: LevelBoundary) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension LevelBoundary: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

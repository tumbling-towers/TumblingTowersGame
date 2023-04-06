//
//  Platform.swift
//  Facade
//
//  Created by Quan Teng Foong on 11/3/23.
//

import CoreGraphics
import Foundation

class Platform: GameWorldObject {

    let fiziksBody: FiziksBody

    var shape: ObjectShape

    var rotation: Double {
        fiziksBody.zRotation
    }

    static var categoryBitMask: BitMask = CategoryMask.platform

    static var collisionBitMask: BitMask = CollisionMask.platform

    static var contactTestBitMask: BitMask = ContactTestMask.platform

    init(fiziksBody: FiziksBody, shape: ObjectShape) {
        self.fiziksBody = fiziksBody
        self.shape = shape
    }
}

extension Platform: Equatable {
    static func == (lhs: Platform, rhs: Platform) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension Platform: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
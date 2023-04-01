//
//  PowerupLine.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 27/3/23.
//

import CoreGraphics
import Foundation

class PowerupLine: GameEngineObject {

    let fiziksBody: FiziksBody

    var shape: ObjectShape

    var rotation: Double {
        fiziksBody.zRotation
    }

    static var categoryBitMask: BitMask = CategoryMask.powerupLine

    static var collisionBitMask: BitMask = CollisionMask.none

    static var contactTestBitMask: BitMask = ContactTestMask.powerupLine

    init(fiziksBody: FiziksBody, shape: ObjectShape) {
        self.fiziksBody = fiziksBody
        self.shape = shape
    }
}

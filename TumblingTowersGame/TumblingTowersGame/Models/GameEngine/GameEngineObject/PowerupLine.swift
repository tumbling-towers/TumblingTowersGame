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

    static var categoryBitmask: BitMask = CategoryMask.powerupLine

    static var collisionBitmask: BitMask = CollisionMask.none

    static var contactTestBitmask: BitMask = ContactTestMask.none

    init(fiziksBody: FiziksBody, shape: ObjectShape) {
        self.fiziksBody = fiziksBody
        self.shape = shape
    }
}


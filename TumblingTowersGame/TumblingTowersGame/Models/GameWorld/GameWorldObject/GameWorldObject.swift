//
//  GameWorldObject.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 8/3/23.
//

import CoreGraphics
import Foundation
import Fiziks

protocol GameWorldObject: AnyObject {
    var fiziksBody: FiziksBody { get }

    var shape: ObjectShape { get }

    var rotation: Double { get }
    
    var specialProperties: SpecialProperties { get set }

    static var categoryBitMask: BitMask { get }

    static var collisionBitMask: BitMask { get }

    static var contactTestBitMask: BitMask { get }
}

extension GameWorldObject {
    var position: CGPoint {
        fiziksBody.position
    }

    var zRotation: CGFloat {
        fiziksBody.zRotation
    }

    var width: Double {
        shape.width * abs(cos(rotation)) + shape.height * abs(sin(rotation))
    }

    var height: Double {
        shape.height * abs(cos(rotation)) + shape.width * abs(sin(rotation))
    }
}

//
//  GameEngineObject.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 8/3/23.
//

import CoreGraphics
import Foundation

protocol GameEngineObject: AnyObject {
    var fiziksBody: FiziksBody { get }

    var shape: ObjectShape { get }

    var rotation: Double { get }

    static var categoryBitMask: BitMask { get }

    static var collisionBitMask: BitMask { get }

    static var contactTestBitMask: BitMask { get }
}

extension GameEngineObject {
    var position: CGPoint {
        fiziksBody.position
    }

    var zRotation: CGFloat {
        fiziksBody.zRotation
    }
}

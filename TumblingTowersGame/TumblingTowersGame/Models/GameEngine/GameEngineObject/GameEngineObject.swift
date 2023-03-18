//
//  GameEngineObject.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 8/3/23.
//

import CoreGraphics
import Foundation

protocol GameEngineObject {
    var fiziksBody: FiziksBody { get }
    var path: CGPath { get }

    static var categoryBitmask: BitMask { get }

    static var collisionBitmask: BitMask { get }

    static var contactTestBitmask: BitMask { get }
}

extension GameEngineObject {
    var position: CGPoint {
        fiziksBody.position
    }
    
    var zRotation: CGFloat {
        fiziksBody.zRotation
    }
}

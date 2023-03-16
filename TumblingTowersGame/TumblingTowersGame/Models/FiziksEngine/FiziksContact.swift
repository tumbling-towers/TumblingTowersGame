//
//  FiziksContact.swift
//  Facade
//
//  Created by Quan Teng Foong on 15/3/23.
//

import Foundation
import SpriteKit

class FiziksContact {
    let bodyA: FiziksBody
    let bodyB: FiziksBody
    let contactPoint: CGPoint
    let collisionImpulse: CGFloat
    let contactNormal: CGVector

    init(bodyA: FiziksBody,
         bodyB: FiziksBody,
         contactPoint: CGPoint,
         collisionImpulse: CGFloat,
         contactNormal: CGVector) {
        self.bodyA = bodyA
        self.bodyB = bodyB
        self.contactPoint = contactPoint
        self.collisionImpulse = collisionImpulse
        self.contactNormal = contactNormal
    }
}

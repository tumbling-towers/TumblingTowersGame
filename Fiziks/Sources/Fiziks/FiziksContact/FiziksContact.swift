//
//  FiziksContact.swift
//  Facade
//
//  Created by Quan Teng Foong on 15/3/23.
//

import Foundation

public class FiziksContact {
    public let bodyA: FiziksBody
    public let bodyB: FiziksBody
    public let contactPoint: CGPoint
    public let collisionImpulse: CGFloat
    public let contactNormal: CGVector

    public init(bodyA: FiziksBody,
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

    public func contains(body: FiziksBody?) -> Bool {
        if let body = body {
            return bodyA === body || bodyB === body
        } else {
            return false
        }
    }
}

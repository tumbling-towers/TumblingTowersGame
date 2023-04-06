//
//  FiziksMocks.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import Foundation
import SpriteKit
@testable import TumblingTowersGame

class MockFiziksBody: FiziksBody {
    var fiziksShapeNode: FiziksShapeNode

    var velocity: CGVector?

    var angularVelocity: CGFloat?

    var isResting: Bool?

    var affectedByGravity: Bool?

    var allowsRotation: Bool?

    var isDynamic: Bool?

    var mass: CGFloat?

    var density: CGFloat?

    var area: CGFloat?

    var friction: CGFloat?

    var restitution: CGFloat?

    var linearDamping: CGFloat?

    var angularDamping: CGFloat?

    var categoryBitMask: BitMask?

    var collisionBitMask: BitMask?

    var contactTestBitMask: BitMask?

    var usesPreciseCollisionDetection: Bool?

    var position: CGPoint

    var zRotation: CGFloat

    static let defaultRect = CGRect(x: .zero, y: .zero, width: 1, height: 1)

    static let defaultSize = CGSize(width: 1, height: 1)

    init(position: CGPoint = FiziksConstants.defaultPosition,
         zRotation: CGFloat = FiziksConstants.defaultZRotation,
         velocity: CGVector = FiziksConstants.defaultVelocity,
         angularVelocity: CGFloat = FiziksConstants.defaultAngularVelocity,
         isResting: Bool = FiziksConstants.defaultIsResting,
         affectedByGravity: Bool = FiziksConstants.defaultAffectedByGravity,
         allowsRotation: Bool = FiziksConstants.defaultAllowsRotation,
         isDynamic: Bool = FiziksConstants.defaultIsDynamic,
         mass: CGFloat = FiziksConstants.defaultMass,
         density: CGFloat = FiziksConstants.defaultDensity,
         friction: CGFloat = FiziksConstants.defaultFriction,
         restitution: CGFloat = FiziksConstants.defaultRestitution,
         linearDamping: CGFloat = FiziksConstants.defaultLinearDamping,
         angularDamping: CGFloat = FiziksConstants.defaultAngularDamping,
         categoryBitMask: BitMask = FiziksConstants.defaultCategoryBitMask,
         collisionBitMask: BitMask = FiziksConstants.defaultCollisionBitMask,
         contactTestBitMask: BitMask = FiziksConstants.defaultContactTestBitMask,
         usesPreciseCollisionDetection: Bool = FiziksConstants.defaultUsesPreciseCollisionDetection) {

        self.position = position
        self.zRotation = zRotation

        self.velocity = velocity
        self.angularVelocity = angularVelocity
        self.isResting = isResting

        self.affectedByGravity = affectedByGravity
        self.allowsRotation = allowsRotation
        self.isDynamic = isDynamic

        self.mass = mass
        self.density = density
        self.friction = friction
        self.restitution = restitution
        self.linearDamping = linearDamping
        self.angularDamping = angularDamping

        self.categoryBitMask = categoryBitMask
        self.collisionBitMask = collisionBitMask
        self.contactTestBitMask = contactTestBitMask
        self.usesPreciseCollisionDetection = usesPreciseCollisionDetection

        self.fiziksShapeNode = MockFiziksShapeNode()
    }

    func applyForce(_ force: CGVector) {
        return
    }

    func applyTorque(_ torque: CGFloat) {
        return
    }

    func applyForce(_ force: CGVector, at point: CGPoint) {
        return
    }

    func applyImpulse(_ impulse: CGVector) {
        return
    }

    func applyAngularImpulse(_ angularImpulse: CGFloat) {
        return
    }

    func applyImpulse(_ impulse: CGVector, at point: CGPoint) {
        return
    }
}

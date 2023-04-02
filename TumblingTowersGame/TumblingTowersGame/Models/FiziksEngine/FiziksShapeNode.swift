//
//  FiziksNode.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 21/3/23.
//

import Foundation
import SpriteKit

class FiziksShapeNode: SKShapeNode {
    weak var fiziksBody: FiziksBody?

    init(path: CGPath) {
        fiziksBody = nil
        super.init()
        self.path = path
    }

    required init?(coder aDecoder: NSCoder) {
        nil
    }

    // MARK: Attributes of a physics body with respect to the world
    // `position` and `zRotation` can already be directly accessed
    var velocity: CGVector? {
        get {
            physicsBody?.velocity
        }
        set {
            physicsBody?.velocity = newValue ?? FiziksConstants.defaultVelocity
        }
    }

    var angularVelocity: CGFloat? {
        get {
            physicsBody?.angularVelocity
        }
        set {
            physicsBody?.angularVelocity = newValue ?? FiziksConstants.defaultAngularVelocity
        }
    }

    var isResting: Bool? {
        get {
            physicsBody?.isResting
        }
        set {
            physicsBody?.isResting = newValue ?? FiziksConstants.defaultIsResting
        }
    }

    // MARK: Attributes defining how forces affect a physics body
    var affectedByGravity: Bool? {
        get {
            physicsBody?.affectedByGravity
        }
        set {
            physicsBody?.affectedByGravity = newValue ?? FiziksConstants.defaultAffectedByGravity
        }
    }

    var allowsRotation: Bool? {
        get {
            physicsBody?.allowsRotation
        }
        set {
            physicsBody?.allowsRotation = newValue ?? FiziksConstants.defaultAllowsRotation
        }
    }

    var isDynamic: Bool? {
        get {
            physicsBody?.isDynamic
        }
        set {
            physicsBody?.isDynamic = newValue ?? FiziksConstants.defaultIsDynamic
        }
    }

    // MARK: Attributes defining a physics body's physical properties
    var mass: CGFloat? {
        get {
            physicsBody?.mass
        }
        set {
            physicsBody?.mass = newValue ?? FiziksConstants.defaultMass
        }
    }

    var density: CGFloat? {
        get {
            physicsBody?.density
        }
        set {
            physicsBody?.density = newValue ?? FiziksConstants.defaultDensity
        }
    }

    var area: CGFloat? {
        physicsBody?.area
    }

    var friction: CGFloat? {
        get {
            physicsBody?.friction
        }
        set {
            physicsBody?.friction = newValue ?? FiziksConstants.defaultFriction
        }
    }

    var restitution: CGFloat? {
        get {
            physicsBody?.restitution
        }
        set {
            physicsBody?.restitution = newValue ?? FiziksConstants.defaultRestitution
        }
    }

    var linearDamping: CGFloat? {
        get {
            physicsBody?.linearDamping
        }
        set {
            physicsBody?.linearDamping = newValue ?? FiziksConstants.defaultLinearDamping
        }
    }

    var angularDamping: CGFloat? {
        get {
            physicsBody?.angularDamping
        }
        set {
            physicsBody?.angularDamping = newValue ?? FiziksConstants.defaultAngularDamping
        }
    }

    // MARK: Attributes for working with collisions and contacts
    var categoryBitMask: BitMask? {
        get {
            physicsBody?.categoryBitMask
        }
        set {
            physicsBody?.categoryBitMask = newValue ?? FiziksConstants.defaultCategoryBitMask
        }
    }

    var collisionBitMask: BitMask? {
        get {
            physicsBody?.collisionBitMask
        }
        set {
            physicsBody?.collisionBitMask = newValue ?? FiziksConstants.defaultCollisionBitMask
        }
    }

    var contactTestBitMask: BitMask? {
        get {
            physicsBody?.contactTestBitMask
        }
        set {
            physicsBody?.contactTestBitMask = newValue ?? FiziksConstants.defaultContactTestBitMask
        }
    }

    var usesPreciseCollisionDetection: Bool? {
        get {
            physicsBody?.usesPreciseCollisionDetection
        }
        set {
            physicsBody?.usesPreciseCollisionDetection = newValue
            ?? FiziksConstants.defaultUsesPreciseCollisionDetection
        }
    }

    // MARK: Methods to apply forces and impulses to a physics body
    func applyForce(_ force: CGVector) {
        physicsBody?.applyForce(force)
    }

    func applyTorque(_ torque: CGFloat) {
        physicsBody?.applyTorque(torque)
    }

    func applyForce(_ force: CGVector, at point: CGPoint) {
        physicsBody?.applyForce(force, at: point)
    }

    func applyImpulse(_ impulse: CGVector) {
        physicsBody?.applyImpulse(impulse)
    }

    func applyAngularImpulse(_ angularImpulse: CGFloat) {
        physicsBody?.applyAngularImpulse(angularImpulse)
    }

    func applyImpulse(_ impulse: CGVector, at point: CGPoint) {
        physicsBody?.applyImpulse(impulse, at: point)
    }

    // MARK: Update methods
    func didUpdatePosition(to newValue: CGPoint) {
        let tempPhysicsBody = physicsBody
        guard let tempPhysicsBodyVelocity = tempPhysicsBody?.velocity else {
            return
        }
        physicsBody = nil

        // Only this following line is important. The rest is a
        // workaround for a stupid SpriteKit problem:
        // https://stackoverflow.com/questions/21370597/sknode-position-not-working-always-going-to-default-0-0
        position = newValue

        physicsBody = tempPhysicsBody
        physicsBody?.velocity = tempPhysicsBodyVelocity
    }

    func didUpdateZRotation(to newValue: CGFloat) {
        zRotation = newValue
    }

    func didUpdateVelocity(to newValue: CGVector) {
        physicsBody?.velocity = newValue
    }

    func didUpdateAngularVelocity(to newValue: CGFloat) {
        physicsBody?.angularVelocity = newValue
    }

    func didUpdateIsResting(to newValue: Bool) {
        physicsBody?.isResting = newValue
    }

    func didUpdateAffectedByGravity(to newValue: Bool) {
        physicsBody?.affectedByGravity = newValue
    }

    func didUpdateAllowsRotation(to newValue: Bool) {
        physicsBody?.allowsRotation = newValue
    }

    func didUpdateIsDynamic(to newValue: Bool) {
        physicsBody?.isDynamic = newValue
    }

    func didUpdateMass(to newValue: CGFloat) {
        physicsBody?.mass = newValue
    }

    func didUpdateDensity(to newValue: CGFloat) {
        physicsBody?.density = newValue
    }

    func didUpdateFriction(to newValue: CGFloat) {
        physicsBody?.friction = newValue
    }

    func didUpdateRestitution(to newValue: CGFloat) {
        physicsBody?.restitution = newValue
    }

    func didUpdateLinearDamping(to newValue: CGFloat) {
        physicsBody?.linearDamping = newValue
    }

    func didUpdateAngularDamping(to newValue: CGFloat) {
        physicsBody?.angularDamping = newValue
    }

    func didUpdateCategoryBitMask(to newValue: BitMask) {
        physicsBody?.categoryBitMask = newValue
    }

    func didUpdateCollisionBitMask(to newValue: BitMask) {
        physicsBody?.collisionBitMask = newValue
    }

    func didUpdateContactTestBitMask(to newValue: BitMask) {
        physicsBody?.contactTestBitMask = newValue
    }

    func didUpdateUsesPreciseCollisionDetection(to newValue: Bool) {
        physicsBody?.usesPreciseCollisionDetection = newValue
    }

}

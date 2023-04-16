//
//  FiziksNode.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 21/3/23.
//

import Foundation
import SpriteKit

public class FiziksShapeNode: SKShapeNode {
    weak var fiziksBody: FiziksBody?

    init(path: CGPath) {
        fiziksBody = nil
        super.init()
        self.path = path
        self.physicsBody = SKPhysicsBody(polygonFrom: path)
    }

    convenience init(rect: CGRect) {
        let path = CGPath(rect: rect, transform: nil)
        self.init(path: path)
    }

    convenience init(circleOfRadius radius: CGFloat) {
        let rect = CGRect(x: -radius, y: -radius, width: radius * 2, height: radius * 2)
        let path = CGPath(ellipseIn: rect, transform: nil)
        self.init(path: path)
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
}

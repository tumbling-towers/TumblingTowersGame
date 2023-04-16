//
//  File.swift
//  
//
//  Created by Quan Teng Foong on 16/4/23.
//

import Foundation

extension GameFiziksBody {
    // MARK: Attributes of a physics body with respect to the world
    public var position: CGPoint {
        get {
            fiziksShapeNode.position
        }
        set {
            if newValue != position {
                fiziksShapeNode.position = newValue
            }
        }
    }

    public var zRotation: CGFloat {
        get {
            fiziksShapeNode.zRotation
        }
        set {
            if newValue != zRotation {
                fiziksShapeNode.zRotation = newValue
            }
        }
    }

    public var velocity: CGVector? {
        get {
            fiziksShapeNode.velocity
        }
        set {
            fiziksShapeNode.velocity = newValue
        }
    }

    public var angularVelocity: CGFloat? {
        get {
            fiziksShapeNode.angularVelocity
        }
        set {
            fiziksShapeNode.angularVelocity = newValue
        }
    }

    public var isResting: Bool? {
        get {
            fiziksShapeNode.isResting
        }
        set {
            fiziksShapeNode.isResting = newValue
        }
    }

    // MARK: Attributes defining how forces affect a physics body
    public var affectedByGravity: Bool? {
        get {
            fiziksShapeNode.affectedByGravity
        }
        set {
            fiziksShapeNode.affectedByGravity = newValue
        }
    }

    public var allowsRotation: Bool? {
        get {
            fiziksShapeNode.allowsRotation
        }
        set {
            fiziksShapeNode.allowsRotation = newValue
        }
    }

    public var isDynamic: Bool? {
        get {
            fiziksShapeNode.isDynamic
        }
        set {
            fiziksShapeNode.isDynamic = newValue
        }
    }

    // MARK: Attributes defining a physics body's physical properties
    public var mass: CGFloat? {
        get {
            fiziksShapeNode.mass
        }
        set {
            fiziksShapeNode.mass = newValue
        }
    }

    public var density: CGFloat? {
        get {
            fiziksShapeNode.density
        }
        set {
            fiziksShapeNode.density = newValue
        }
    }

    public var area: CGFloat? {
        fiziksShapeNode.area
    }

    public var friction: CGFloat? {
        get {
            fiziksShapeNode.friction
        }
        set {
            fiziksShapeNode.friction = newValue
        }
    }

    public var restitution: CGFloat? {
        get {
            fiziksShapeNode.restitution
        }
        set {
            fiziksShapeNode.restitution = newValue
        }
    }

    public var linearDamping: CGFloat? {
        get {
            fiziksShapeNode.linearDamping
        }
        set {
            fiziksShapeNode.linearDamping = newValue
        }
    }

    public var angularDamping: CGFloat? {
        get {
            fiziksShapeNode.angularDamping
        }
        set {
            fiziksShapeNode.angularDamping = newValue
        }
    }

    // MARK: Attributes for working with collisions and contacts
    public var categoryBitMask: BitMask? {
        get {
            fiziksShapeNode.categoryBitMask
        }
        set {
            fiziksShapeNode.categoryBitMask = newValue
        }
    }

    public var collisionBitMask: BitMask? {
        get {
            fiziksShapeNode.collisionBitMask
        }
        set {
            fiziksShapeNode.collisionBitMask = newValue
        }
    }

    public var contactTestBitMask: BitMask? {
        get {
            fiziksShapeNode.contactTestBitMask
        }
        set {
            fiziksShapeNode.contactTestBitMask = newValue
        }
    }

    public var usesPreciseCollisionDetection: Bool? {
        get {
            fiziksShapeNode.usesPreciseCollisionDetection
        }
        set {
            fiziksShapeNode.usesPreciseCollisionDetection = newValue
        }
    }
}

/**
 A concreate implementation of `FiziksBody`.
 */

import CoreGraphics
import Foundation
import SpriteKit

public class GameFiziksBody: FiziksBody {
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

    // MARK: Methods to apply forces and impulses to a physics body
    public func applyForce(_ force: CGVector) {
        fiziksShapeNode.applyForce(force)
    }

    public func applyTorque(_ torque: CGFloat) {
        fiziksShapeNode.applyTorque(torque)
    }

    public func applyForce(_ force: CGVector, at point: CGPoint) {
        fiziksShapeNode.applyForce(force, at: point)
    }

    public func applyImpulse(_ impulse: CGVector) {
        fiziksShapeNode.applyImpulse(impulse)
    }

    public func applyAngularImpulse(_ angularImpulse: CGFloat) {
        fiziksShapeNode.applyAngularImpulse(angularImpulse)
    }

    public func applyImpulse(_ impulse: CGVector, at point: CGPoint) {
        fiziksShapeNode.applyImpulse(impulse, at: point)
    }

    public var fiziksShapeNode: FiziksShapeNode

    /// Note that any shape can be represented with a `CGPath`.
    var path: CGPath? {
        get {
            fiziksShapeNode.path
        }
        set {
            fiziksShapeNode.path = newValue
        }
    }

    public init(path: CGPath,
         position: CGPoint = FiziksConstants.defaultPosition,
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
        fiziksShapeNode = FiziksShapeNode(path: path)
        fiziksShapeNode.fiziksBody = self

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
    }
    
    /// Proof of concept that initializers for other-shaped `GameFiziksBody`s
    /// can be created easily. Note that `self.path` stays the same as
    /// a `CGPath` is used to represent all shapes.
    public init(rect: CGRect,
         position: CGPoint = FiziksConstants.defaultPosition,
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
        fiziksShapeNode = FiziksShapeNode(rect: rect)
        fiziksShapeNode.fiziksBody = self
        
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
    }
}

extension GameFiziksBody: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(position)"
    }
}

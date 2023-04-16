/**
 A concreate implementation of `FiziksBody`.
 */

import CoreGraphics
import Foundation
import SpriteKit

class GameFiziksBody: FiziksBody {
    // MARK: Attributes of a physics body with respect to the world
    var position: CGPoint {
        get {
            fiziksShapeNode.position
        }
        set {
            if newValue != position {
                fiziksShapeNode.position = newValue
            }
        }
    }

    var zRotation: CGFloat {
        get {
            fiziksShapeNode.zRotation
        }
        set {
            if newValue != zRotation {
                fiziksShapeNode.zRotation = newValue
            }
        }
    }

    var velocity: CGVector? {
        get {
            fiziksShapeNode.velocity
        }
        set {
            fiziksShapeNode.velocity = newValue
        }
    }

    var angularVelocity: CGFloat? {
        get {
            fiziksShapeNode.angularVelocity
        }
        set {
            fiziksShapeNode.angularVelocity = newValue
        }
    }

    var isResting: Bool? {
        get {
            fiziksShapeNode.isResting
        }
        set {
            fiziksShapeNode.isResting = newValue
        }
    }

    // MARK: Attributes defining how forces affect a physics body
    var affectedByGravity: Bool? {
        get {
            fiziksShapeNode.affectedByGravity
        }
        set {
            fiziksShapeNode.affectedByGravity = newValue
        }
    }

    var allowsRotation: Bool? {
        get {
            fiziksShapeNode.allowsRotation
        }
        set {
            fiziksShapeNode.allowsRotation = newValue
        }
    }

    var isDynamic: Bool? {
        get {
            fiziksShapeNode.isDynamic
        }
        set {
            fiziksShapeNode.isDynamic = newValue
        }
    }

    // MARK: Attributes defining a physics body's physical properties
    var mass: CGFloat? {
        get {
            fiziksShapeNode.mass
        }
        set {
            fiziksShapeNode.mass = newValue
        }
    }

    var density: CGFloat? {
        get {
            fiziksShapeNode.density
        }
        set {
            fiziksShapeNode.density = newValue
        }
    }

    var area: CGFloat? {
        fiziksShapeNode.area
    }

    var friction: CGFloat? {
        get {
            fiziksShapeNode.friction
        }
        set {
            fiziksShapeNode.friction = newValue
        }
    }

    var restitution: CGFloat? {
        get {
            fiziksShapeNode.restitution
        }
        set {
            fiziksShapeNode.restitution = newValue
        }
    }

    var linearDamping: CGFloat? {
        get {
            fiziksShapeNode.linearDamping
        }
        set {
            fiziksShapeNode.linearDamping = newValue
        }
    }

    var angularDamping: CGFloat? {
        get {
            fiziksShapeNode.angularDamping
        }
        set {
            fiziksShapeNode.angularDamping = newValue
        }
    }

    // MARK: Attributes for working with collisions and contacts
    var categoryBitMask: BitMask? {
        get {
            fiziksShapeNode.categoryBitMask
        }
        set {
            fiziksShapeNode.categoryBitMask = newValue
        }
    }

    var collisionBitMask: BitMask? {
        get {
            fiziksShapeNode.collisionBitMask
        }
        set {
            fiziksShapeNode.collisionBitMask = newValue
        }
    }

    var contactTestBitMask: BitMask? {
        get {
            fiziksShapeNode.contactTestBitMask
        }
        set {
            fiziksShapeNode.contactTestBitMask = newValue
        }
    }

    var usesPreciseCollisionDetection: Bool? {
        get {
            fiziksShapeNode.usesPreciseCollisionDetection
        }
        set {
            fiziksShapeNode.usesPreciseCollisionDetection = newValue
        }
    }

    // MARK: Methods to apply forces and impulses to a physics body
    func applyForce(_ force: CGVector) {
        fiziksShapeNode.applyForce(force)
    }

    func applyTorque(_ torque: CGFloat) {
        fiziksShapeNode.applyTorque(torque)
    }

    func applyForce(_ force: CGVector, at point: CGPoint) {
        fiziksShapeNode.applyForce(force, at: point)
    }

    func applyImpulse(_ impulse: CGVector) {
        fiziksShapeNode.applyImpulse(impulse)
    }

    func applyAngularImpulse(_ angularImpulse: CGFloat) {
        fiziksShapeNode.applyAngularImpulse(angularImpulse)
    }

    func applyImpulse(_ impulse: CGVector, at point: CGPoint) {
        fiziksShapeNode.applyImpulse(impulse, at: point)
    }

    var fiziksShapeNode: FiziksShapeNode

    /// Note that any shape can be represented with a `CGPath`.
    var path: CGPath? {
        get {
            fiziksShapeNode.path
        }
        set {
            fiziksShapeNode.path = newValue
        }
    }

    init(path: CGPath,
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
    init(rect: CGRect,
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
    var debugDescription: String {
        "\(position)"
    }
}

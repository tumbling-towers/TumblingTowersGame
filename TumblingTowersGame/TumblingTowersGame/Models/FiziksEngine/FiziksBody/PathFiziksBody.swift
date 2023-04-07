/**
 A `FiziksBody` which has a shape represented using a `CGPath`.
 */

import CoreGraphics
import Foundation
import SpriteKit

class PathFiziksBody: FiziksBody {
    // MARK: Attributes of a physics body with respect to the world
    var position: CGPoint {
        get {
            fiziksShapeNode.position
        }
        set {
            if newValue != position {
                fiziksShapeNode.didUpdatePosition(to: newValue)
            }
        }
    }

    var zRotation: CGFloat {
        get {
            fiziksShapeNode.zRotation
        }
        set {
            if newValue != zRotation {
                fiziksShapeNode.didUpdateZRotation(to: newValue)
            }
        }
    }

    var velocity: CGVector? {
        get {
            fiziksShapeNode.velocity
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != velocity {
                fiziksShapeNode.didUpdateVelocity(to: unwrappedNewValue)
            }
        }
    }

    var angularVelocity: CGFloat? {
        get {
            fiziksShapeNode.angularVelocity
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != angularVelocity {
                fiziksShapeNode.didUpdateAngularVelocity(to: unwrappedNewValue)
            }
        }
    }

    var isResting: Bool? {
        get {
            fiziksShapeNode.isResting
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != isResting {
                fiziksShapeNode.didUpdateIsResting(to: unwrappedNewValue)
            }
        }
    }

    // MARK: Attributes defining how forces affect a physics body
    var affectedByGravity: Bool? {
        get {
            fiziksShapeNode.affectedByGravity
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != affectedByGravity {
                fiziksShapeNode.didUpdateAffectedByGravity(to: unwrappedNewValue)
            }
        }
    }

    var allowsRotation: Bool? {
        get {
            fiziksShapeNode.allowsRotation
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != allowsRotation {
                fiziksShapeNode.didUpdateAllowsRotation(to: unwrappedNewValue)
            }
        }
    }

    var isDynamic: Bool? {
        get {
            fiziksShapeNode.isDynamic
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != isDynamic {
                fiziksShapeNode.didUpdateIsDynamic(to: unwrappedNewValue)
            }
        }
    }

    // MARK: Attributes defining a physics body's physical properties
    var mass: CGFloat? {
        get {
            fiziksShapeNode.mass
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != mass {
                fiziksShapeNode.didUpdateMass(to: unwrappedNewValue)
            }
        }
    }

    var density: CGFloat? {
        get {
            fiziksShapeNode.density
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != density {
                fiziksShapeNode.didUpdateDensity(to: unwrappedNewValue)
            }
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
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != friction {
                fiziksShapeNode.didUpdateFriction(to: unwrappedNewValue)
            }
        }
    }

    var restitution: CGFloat? {
        get {
            fiziksShapeNode.restitution
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != restitution {
                fiziksShapeNode.didUpdateRestitution(to: unwrappedNewValue)
            }
        }
    }

    var linearDamping: CGFloat? {
        get {
            fiziksShapeNode.linearDamping
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != linearDamping {
                fiziksShapeNode.didUpdateLinearDamping(to: unwrappedNewValue)
            }
        }
    }

    var angularDamping: CGFloat? {
        get {
            fiziksShapeNode.angularDamping
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != angularDamping {
                fiziksShapeNode.didUpdateAngularDamping(to: unwrappedNewValue)
            }
        }
    }

    // MARK: Attributes for working with collisions and contacts
    var categoryBitMask: BitMask? {
        get {
            fiziksShapeNode.categoryBitMask
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != categoryBitMask {
                fiziksShapeNode.didUpdateCategoryBitMask(to: unwrappedNewValue)
            }
        }
    }

    var collisionBitMask: BitMask? {
        get {
            fiziksShapeNode.collisionBitMask
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != collisionBitMask {
                fiziksShapeNode.didUpdateCollisionBitMask(to: unwrappedNewValue)
            }
        }
    }

    var contactTestBitMask: BitMask? {
        get {
            fiziksShapeNode.contactTestBitMask
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != contactTestBitMask {
                fiziksShapeNode.didUpdateContactTestBitMask(to: unwrappedNewValue)
            }
        }
    }

    var usesPreciseCollisionDetection: Bool? {
        get {
            fiziksShapeNode.usesPreciseCollisionDetection
        }
        set {
            if let unwrappedNewValue = newValue,
                unwrappedNewValue != usesPreciseCollisionDetection {
                fiziksShapeNode.didUpdateUsesPreciseCollisionDetection(to: unwrappedNewValue)
            }
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
        fiziksShapeNode.physicsBody = SKPhysicsBody(polygonFrom: path)
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

extension PathFiziksBody: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(position)"
    }
}

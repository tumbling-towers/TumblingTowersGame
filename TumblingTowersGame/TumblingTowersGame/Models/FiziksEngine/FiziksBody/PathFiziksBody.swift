/**
 A `FiziksBody` which has a shape represented using a `CGPath`.
 */

import CoreGraphics
import Foundation
import SpriteKit

class PathFiziksBody: FiziksBody {
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

    init(path: CGPath) {
        self.fiziksShapeNode = FiziksShapeNode(path: path)
        self.fiziksShapeNode.physicsBody = SKPhysicsBody(polygonFrom: path)
        self.fiziksShapeNode.fiziksBody = self
        
        self.position = FiziksConstants.defaultPosition
        self.zRotation = FiziksConstants.defaultZRotation
        
        self.velocity = FiziksConstants.defaultVelocity
        self.angularVelocity = FiziksConstants.defaultAngularVelocity
        self.isResting = FiziksConstants.defaultIsResting
        
        self.affectedByGravity = FiziksConstants.defaultAffectedByGravity
        self.allowsRotation = FiziksConstants.defaultAffectedByGravity
        self.isDynamic = FiziksConstants.defaultIsDynamic
        
        self.mass = FiziksConstants.defaultMass
        self.density = FiziksConstants.defaultDensity
        self.friction = FiziksConstants.defaultFriction
        self.restitution = FiziksConstants.defaultRestitution
        self.linearDamping = FiziksConstants.defaultLinearDamping
        self.angularDamping = FiziksConstants.defaultAngularDamping
        
        self.categoryBitMask = FiziksConstants.defaultCategoryBitMask
        self.collisionBitMask = FiziksConstants.defaultCollisionBitMask
        self.contactTestBitMask = FiziksConstants.defaultContactTestBitMask
        self.usesPreciseCollisionDetection = FiziksConstants.defaultUsesPreciseCollisionDetection
    }
}

extension PathFiziksBody: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(position)"
    }
}

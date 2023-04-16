//
//  GameFiziksEngine.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 9/3/23.
//

import Foundation
import SpriteKit

public class GameFiziksEngine: NSObject {
    public let fiziksScene: FiziksScene

    var idToFiziksBody: [ObjectIdentifier: FiziksBody]
    var skNodeToFiziksBody: [SKNode: FiziksBody]

    public weak var fiziksContactDelegate: FiziksContactDelegate?

    public init(size: CGRect) {
        let size = CGSize(width: size.width, height: size.height)
        self.fiziksScene = FiziksScene(size: size)
        self.fiziksContactDelegate = nil
        self.idToFiziksBody = [:]
        self.skNodeToFiziksBody = [:]
        super.init()
        setUpFiziksScene()
        fiziksScene.view?.showsPhysics = true
    }

    private func setUpFiziksScene() {
        fiziksScene.physicsWorld.contactDelegate = self
        fiziksScene.gravity = FiziksConstants.defaultFiziksEngineGravity
    }
}

extension GameFiziksEngine: FiziksEngine {

    public func insertBounds(_ bounds: CGRect) {
        fiziksScene.physicsBody = SKPhysicsBody(edgeLoopFrom: bounds)
    }

    public func contains(_ fiziksBody: FiziksBody) -> Bool {
        let bodyId = ObjectIdentifier(fiziksBody)
        return idToFiziksBody.keys.contains(bodyId)
    }

    public func add(_ fiziksBody: FiziksBody) {
        let bodyId = ObjectIdentifier(fiziksBody)
        idToFiziksBody[bodyId] = fiziksBody
        skNodeToFiziksBody[fiziksBody.fiziksShapeNode] = fiziksBody
        fiziksScene.addChild(fiziksBody)
    }

    public func delete(_ fiziksBody: FiziksBody) {
        let idToDelete = ObjectIdentifier(fiziksBody)
        idToFiziksBody[idToDelete] = nil
        skNodeToFiziksBody[fiziksBody.fiziksShapeNode] = nil
        fiziksScene.remove(fiziksBody)
    }

    public func combine(bodyA: FiziksBody, bodyB: FiziksBody, at anchorPoint: CGPoint? = nil) {
        guard let bodyA = bodyA.fiziksShapeNode.physicsBody,
              let bodyB = bodyB.fiziksShapeNode.physicsBody else { return }

        var pinJoint: SKPhysicsJointPin?

        if let point = anchorPoint {
            pinJoint = SKPhysicsJointPin.joint(withBodyA: bodyA, bodyB: bodyB, anchor: point)
        } else if let posA = bodyA.node?.position, let posB = bodyB.node?.position {
            let meanPos = CGPoint.arithmeticMean(points: [posA, posB])
            pinJoint = SKPhysicsJointPin.joint(withBodyA: bodyA, bodyB: bodyB, anchor: meanPos)
        }

        guard let pinJoint = pinJoint else {
            return
        }

        pinJoint.shouldEnableLimits = true
        fiziksScene.scene?.physicsWorld.add(pinJoint)
    }

    public func setWorldGravity(to newValue: CGVector) {
        fiziksScene.gravity = newValue
    }

    public func allBodiesContacted(with fiziksBody: FiziksBody) -> [FiziksBody] {
        guard let skPhysicsBody = fiziksBody.fiziksShapeNode.physicsBody else {
            return []
        }
        let contactedSKPhysicsBodies = skPhysicsBody.allContactedBodies()
        var contactedFiziksBodies: [FiziksBody] = []
        for body in contactedSKPhysicsBodies {
            guard let node = body.node,
                  let contactedFiziksBody = skNodeToFiziksBody[node] else {
                continue
            }
            contactedFiziksBodies.append(contactedFiziksBody)
        }
        return contactedFiziksBodies
    }

    public func isIntersecting(body: FiziksBody, otherBodies: [FiziksBody]) -> Bool {
        for otherBody in otherBodies where body.fiziksShapeNode.intersects(otherBody.fiziksShapeNode) {
            return true
        }

        return false
    }

    public func deleteAllBodies() {
        for (id, fiziksBody) in idToFiziksBody {
            idToFiziksBody[id] = nil
            skNodeToFiziksBody[fiziksBody.fiziksShapeNode] = nil
            fiziksScene.remove(fiziksBody)
        }

        fiziksScene.removeAllChildren()
    }

    public func pause() {
        fiziksScene.pause()
    }

    public func unpause() {
        fiziksScene.unpause()
    }

    private func getSKPhysicsBody(of fiziksBody: FiziksBody) -> SKPhysicsBody? {
        fiziksBody.fiziksShapeNode.physicsBody
    }
}

extension GameFiziksEngine: SKPhysicsContactDelegate {
    // Called when contact between two physics bodies begins in physics world
    public func didBegin(_ contact: SKPhysicsContact) {
        guard let fiziksContact = createFiziksContact(skPhysicsContact: contact) else {
            return
        }
        fiziksContactDelegate?.didBegin(fiziksContact)
    }

    // Called when contact between two physics bodies ends in physics world
    public func didEnd(_ contact: SKPhysicsContact) {
        guard let fiziksContact = createFiziksContact(skPhysicsContact: contact) else {
            return
        }
        fiziksContactDelegate?.didEnd(fiziksContact)
    }

    private func createFiziksContact(skPhysicsContact: SKPhysicsContact) -> FiziksContact? {
        guard let nodeA = skPhysicsContact.bodyA.node,
              let nodeB = skPhysicsContact.bodyB.node,
              let fiziksBodyA = (nodeA as? FiziksShapeNode)?.fiziksBody,
              let fiziksBodyB = (nodeB as? FiziksShapeNode)?.fiziksBody else {
            return nil
        }
        return FiziksContact(bodyA: fiziksBodyA,
                             bodyB: fiziksBodyB,
                             contactPoint: skPhysicsContact.contactPoint,
                             collisionImpulse: skPhysicsContact.collisionImpulse,
                             contactNormal: skPhysicsContact.contactNormal)
    }
}

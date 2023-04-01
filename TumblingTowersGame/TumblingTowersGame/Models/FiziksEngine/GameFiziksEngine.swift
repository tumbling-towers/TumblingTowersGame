//
//  GameFiziksEngine.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 9/3/23.
//

import Foundation
import SpriteKit

class GameFiziksEngine: NSObject {
    let fiziksScene: FiziksScene

    // Basically a Set<FiziksBody>, except we can't hash
    // a protocol, so this is the temp solution. May consider
    // creating a new data structure for this purpose.
    var idToFiziksBody: [ObjectIdentifier: FiziksBody]
    var skNodeToFiziksBody: [SKNode: FiziksBody]

    weak var fiziksContactDelegate: FiziksContactDelegate?

    init(size: CGRect) {
        let size = CGSize(width: size.width, height: size.height)
        self.fiziksScene = FiziksScene(size: size)
        self.fiziksContactDelegate = nil
        self.idToFiziksBody = [:]
        self.skNodeToFiziksBody = [:]
        super.init()
        setUpFiziksScene()
    }

    private func setUpFiziksScene() {
        fiziksScene.physicsWorld.contactDelegate = self
        fiziksScene.gravity = GameFiziksEngine.defaultFiziksEngineGravity
    }
}

extension GameFiziksEngine: FiziksEngine {

    static let defaultFiziksEngineGravity = CGVector(dx: 0, dy: -1.0)

    func insertBounds(_ bounds: CGRect) {
        fiziksScene.physicsBody = SKPhysicsBody(edgeLoopFrom: bounds)
    }

    func activatePhysics() {
        fiziksScene.view?.showsPhysics = true
    }

    func contains(_ fiziksBody: FiziksBody) -> Bool {
        let bodyId = ObjectIdentifier(fiziksBody)
        return idToFiziksBody.keys.contains(bodyId)
    }

    func add(_ fiziksBody: FiziksBody) {
        let bodyId = ObjectIdentifier(fiziksBody)
        idToFiziksBody[bodyId] = fiziksBody
        skNodeToFiziksBody[fiziksBody.fiziksShapeNode] = fiziksBody
        fiziksScene.addChild(fiziksBody)
    }

    func delete(_ fiziksBody: FiziksBody) {
        let idToDelete = ObjectIdentifier(fiziksBody)
        idToFiziksBody[idToDelete] = nil
        skNodeToFiziksBody[fiziksBody.fiziksShapeNode] = nil
        fiziksScene.remove(fiziksBody)
    }
    
    func combine(bodyA: FiziksBody, bodyB: FiziksBody, at anchorPoint: CGPoint? = nil) {
        guard let bodyA = bodyA.fiziksShapeNode.physicsBody,
              let bodyB = bodyB.fiziksShapeNode.physicsBody else { return }
        
        var pinJoint: SKPhysicsJointPin?
        
        if let point = anchorPoint {
            pinJoint = SKPhysicsJointPin.joint(withBodyA: bodyA, bodyB: bodyB, anchor: point)
        } else if let posA = bodyA.node?.position, let posB = bodyB.node?.position {
            let meanPos = CGPoint.arithmeticMean(points: [posA, posB])
            pinJoint = SKPhysicsJointPin.joint(withBodyA: bodyA, bodyB: bodyB, anchor: meanPos)
        }
        
        guard let pinJoint = pinJoint else { return }
        
        pinJoint.shouldEnableLimits = true
        fiziksScene.scene?.physicsWorld.add(pinJoint)
    }

    func setWorldGravity(to newValue: CGVector) {
        fiziksScene.gravity = newValue
    }
    
    func allBodiesContacted(with fiziksBody: FiziksBody) -> [FiziksBody] {
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
    
    func isIntersecting(body: FiziksBody, otherBodies: [FiziksBody]) -> Bool {
        for otherBody in otherBodies {
            if body.fiziksShapeNode.intersects(otherBody.fiziksShapeNode) {
                print(body.position)
                print(otherBody.position)
                return true
            }
        }
        
        return false
    }

    private func getSKPhysicsBody(of fiziksBody: FiziksBody) -> SKPhysicsBody? {
        return fiziksBody.fiziksShapeNode.physicsBody
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

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

    // TODO: Figure out logic on how to create new FiziksBody from combined node
    // As it turns out, SKPhysicsBody(bodies:) doesn't really do what we need, cos
    // it seems to just take the bodies and put them as children of the new body.
    // The problem is that if in that frame there is some overlap, the overlap will
    // stay in the new body. I think this is a good place to use double dispatch actually.
    // Might consider coming up with ways to combine different shapes.
    func combine(_ fiziksBodies: [FiziksBody]) {
        print("check")
        if fiziksBodies.count < 2 {
            return
        }
        
        let skPhysicsBodies = fiziksBodies.compactMap({ getSKPhysicsBody(of: $0) })
        let bodyA = fiziksBodies[1]
        
        let gravityField: SKFieldNode = SKFieldNode.electricField()
        gravityField.position = bodyA.position
        gravityField.physicsBody?.fieldBitMask = CategoryMask.block
        gravityField.strength = 100
        gravityField.falloff = 10
        
        print(bodyA.position)
        print(gravityField.position)
        
        bodyA.fiziksShapeNode.addChild(gravityField)
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

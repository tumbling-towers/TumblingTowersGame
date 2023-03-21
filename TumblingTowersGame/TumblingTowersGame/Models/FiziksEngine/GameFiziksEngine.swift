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
    
    var fiziksBodyIdToSKNode: BiMap<ObjectIdentifier, SKNode>
    var fiziksBodyIdToFiziksBody: [ObjectIdentifier: FiziksBody]

    weak var fiziksContactDelegate: FiziksContactDelegate?
    
    init(levelDimensions: CGRect, boundingRect: CGRect) {
        let size = CGSize(width: levelDimensions.width, height: levelDimensions.height)
        self.fiziksScene = FiziksScene(size: size,
                                       boundingRect: boundingRect)
        self.fiziksBodyIdToSKNode = BiMap()
        self.fiziksBodyIdToFiziksBody = [:]
        self.fiziksContactDelegate = nil
        super.init()
        setUpFiziksScene()
    }

    private func setUpFiziksScene() {
        fiziksScene.physicsWorld.contactDelegate = self
        fiziksScene.fiziksSceneUpdateDelegate = self
        fiziksScene.gravity = GameFiziksEngine.defaultFiziksEngineGravity
    }
}

extension GameFiziksEngine: FiziksEngine {

    static let defaultFiziksEngineGravity = CGVector(dx: 0, dy: -1.0)

    func activatePhysics() {
        fiziksScene.view?.showsPhysics = true
    }
    
    func contains(_ fiziksBody: FiziksBody) -> Bool {
        let bodyId = ObjectIdentifier(fiziksBody)
        return fiziksBodyIdToSKNode[key: bodyId] != nil
    }

    func add(_ fiziksBody: FiziksBody) {
        let node = fiziksBody.createFiziksShapeNode()

        let skPhysicsBody = createSKPhysicsBody(for: fiziksBody)

        // ----- to be removed -----
        node.fillColor = .red
        // -------------------------

        node.physicsBody = skPhysicsBody
        node.position = fiziksBody.position
        
        let bodyId = ObjectIdentifier(fiziksBody)
        fiziksBodyIdToSKNode[key: bodyId] = node
        fiziksBodyIdToFiziksBody[bodyId] = fiziksBody
        
        fiziksBody.delegate = node
        node.fiziksBody = fiziksBody
        
        fiziksScene.addChild(node)
    }

    func delete(_ fiziksBody: FiziksBody) {
        let idToDelete = ObjectIdentifier(fiziksBody)
        let deletedNode = fiziksBodyIdToSKNode[key: idToDelete]
        fiziksBodyIdToSKNode[key: idToDelete] = nil
        fiziksBodyIdToFiziksBody[idToDelete] = nil
        deletedNode?.removeFromParent()
    }

    func move(_ fiziksBody: FiziksBody, to newPosition: CGPoint) {
        fiziksBody.position = newPosition
    }

    func move(_ fiziksBody: FiziksBody, by displacement: CGVector) {
        let oldPosition = fiziksBody.position
        let newPosition = CGPoint(x: oldPosition.x + displacement.dx, y: oldPosition.y + displacement.dy)
        move(fiziksBody, to: newPosition)
        
        let node = fiziksBodyIdToSKNode[key: ObjectIdentifier(fiziksBody)]
        print("Current position \(node?.position.x) ,  \(node?.position.y)")
    }
    
    // TODO: Figure out logic on how to create new FiziksBody from combined node
    func combine(_ fiziksBodies: [FiziksBody]) {
        let skPhysicsBodies = fiziksBodies.compactMap({ getSKPhysicsBody(of: $0) })
        var newCollisionBitmask: BitMask = 0x0
        var newCategoryBitmask: BitMask = 0x0
        var newContactTestBitmask: BitMask = 0x0
        
        fiziksBodies.forEach({
            newCollisionBitmask = newCollisionBitmask | $0.collisionBitMask
            newCategoryBitmask = newCategoryBitmask | $0.categoryBitMask
            newContactTestBitmask = newContactTestBitmask | $0.contactTestBitMask
            delete($0)
        })

        let combinedNode = FiziksShapeNode()
        combinedNode.physicsBody = SKPhysicsBody(bodies: skPhysicsBodies)
        
        fiziksScene.addChild(combinedNode)
    }

    // TODO: rotation works but looks a bit weird. run to see.
    func rotate(_ fiziksBody: FiziksBody, by angle: Double) {
        fiziksBody.zRotation += angle
    }

    func setDynamicValue(_ fiziksBody: FiziksBody, to newValue: Bool) {
        fiziksBody.isDynamic = newValue

        let bodyId = ObjectIdentifier(fiziksBody)
        let node = fiziksBodyIdToSKNode[key: bodyId]
        node?.physicsBody?.isDynamic = newValue
    }

    // TODO: Why don't we just return fiziksBody.isDynamic?
    func isDynamic(_ fiziksBody: FiziksBody) -> Bool {
        let bodyId = ObjectIdentifier(fiziksBody)
        let node = fiziksBodyIdToSKNode[key: bodyId]
        return node?.physicsBody?.isDynamic ?? false
    }

    func setAffectedByGravity(_ fiziksBody: FiziksBody, to newValue: Bool) {
        let bodyId = ObjectIdentifier(fiziksBody)
        let skNode = fiziksBodyIdToSKNode[key: bodyId]
        skNode?.physicsBody?.affectedByGravity = newValue
    }

    func setVelocity(_ fiziksBody: FiziksBody, to newVelocity: CGVector) {
        let bodyId = ObjectIdentifier(fiziksBody)
        let skNode = fiziksBodyIdToSKNode[key: bodyId]
        skNode?.physicsBody?.velocity = CGVector.zero
        skNode?.physicsBody?.applyImpulse(newVelocity)
    }

    func setWorldGravity(to newValue: CGVector) {
        fiziksScene.gravity = newValue
    }
    
    private func createSKPhysicsBody(for fiziksBody: FiziksBody) -> SKPhysicsBody {
        let physicsBody = fiziksBody.createSKPhysicsBody()
        physicsBody.isDynamic = fiziksBody.isDynamic
        physicsBody.collisionBitMask = fiziksBody.collisionBitMask
        physicsBody.contactTestBitMask = fiziksBody.contactTestBitMask
        physicsBody.friction = fiziksBody.friction

        return physicsBody
    }

    private func getSKPhysicsBody(of fiziksBody: FiziksBody) -> SKPhysicsBody? {
        let bodyId = ObjectIdentifier(fiziksBody)
        let node = fiziksBodyIdToSKNode[key: bodyId]
        return node?.physicsBody
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
              let bodyAId = fiziksBodyIdToSKNode[value: nodeA],
              let bodyBId = fiziksBodyIdToSKNode[value: nodeB],
              let fiziksBodyA = fiziksBodyIdToFiziksBody[bodyAId],
              let fiziksBodyB = fiziksBodyIdToFiziksBody[bodyBId] else {
            return nil
        }
        return FiziksContact(bodyA: fiziksBodyA,
                             bodyB: fiziksBodyB,
                             contactPoint: skPhysicsContact.contactPoint,
                             collisionImpulse: skPhysicsContact.collisionImpulse,
                             contactNormal: skPhysicsContact.contactNormal)
    }
}

extension GameFiziksEngine: FiziksSceneUpdateDelegate {
    func didUpdateFiziksScene() {
        
    }
}

//
//  GameScene.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 9/3/23.
//

import Foundation
import SpriteKit

class FiziksEngine: SKScene {
    // TODO: having so many mappings is error prone.
    // consider creating a subclass of SKNode with a reference to a FiziksBody such that
    // whenever one's position gets updated, the other's position automatically follows.
    var fiziksBodyIdToSKNode: BiMap<ObjectIdentifier, SKNode> = BiMap()
    var fiziksBodyIdToFiziksBody: [ObjectIdentifier: FiziksBody] = [:]

    override func didFinishUpdate() {
        // SK has updated all the SKNodes, now update all the FiziksBodies
        updateAllFiziksBodies()
    }

    private func updateAllFiziksBodies() {
        for skNode in fiziksBodyIdToSKNode.values {
            guard let fiziksBodyId = fiziksBodyIdToSKNode[value: skNode],
                  let fiziksBody = fiziksBodyIdToFiziksBody[fiziksBodyId] else {
                continue
            }
            fiziksBody.position = skNode.position
            fiziksBody.zRotation = skNode.zRotation
        }
    }
}

extension FiziksEngine: TumblingTowersScene {
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setUpScene()
    }

    func contains(_ fiziksBody: FiziksBody) -> Bool {
        let bodyId = ObjectIdentifier(fiziksBody)
        return fiziksBodyIdToSKNode[key: bodyId] != nil
    }

    func add(_ fiziksBody: FiziksBody) {
        let node = fiziksBody.fiziksShape.skShapeNode

        let skPhysicsBody = createSKPhysicsBody(for: fiziksBody)

        // ----- to be removed -----
        node.fillColor = .red
        // -------------------------

        node.physicsBody = skPhysicsBody
        node.position = fiziksBody.position

        let bodyId = ObjectIdentifier(fiziksBody)
        fiziksBodyIdToSKNode[key: bodyId] = node
        fiziksBodyIdToFiziksBody[bodyId] = fiziksBody
        addChild(node)
    }

    func delete(_ fiziksBody: FiziksBody) {
        let idToDelete = ObjectIdentifier(fiziksBody)
        let deletedNode = fiziksBodyIdToSKNode[key: idToDelete]
        fiziksBodyIdToSKNode[key: idToDelete] = nil
        fiziksBodyIdToFiziksBody[idToDelete] = nil
        deletedNode?.removeFromParent()
    }

    func move(_ fiziksBody: FiziksBody, to newPosition: CGPoint) {
        let idToMove = ObjectIdentifier(fiziksBody)
        let movedNode = fiziksBodyIdToSKNode[key: idToMove]
        movedNode?.position = newPosition
        let fiziksBody = fiziksBodyIdToFiziksBody[idToMove]
        fiziksBody?.position = newPosition
    }

    func move(_ fiziksBody: FiziksBody, by displacement: CGVector) {
        let idToMove = ObjectIdentifier(fiziksBody)
        guard let movedNode = fiziksBodyIdToSKNode[key: idToMove] else {
            return
        }
        let oldPosition = movedNode.position
        let newPosition = CGPoint(x: oldPosition.x + displacement.dx, y: oldPosition.y + displacement.dy)
        move(fiziksBody, to: newPosition)
    }

    func combine(_ fiziksBodies: [FiziksBody]) {
        let skPhysicsBodies = fiziksBodies.compactMap({ getSKPhysicsBody(of: $0) })
        fiziksBodies.forEach({ delete($0) })

        let combinedNode = SKNode()
        combinedNode.physicsBody = SKPhysicsBody(bodies: skPhysicsBodies)

        addChild(combinedNode)
    }

    func rotate(_ fiziksBody: FiziksBody, by angle: Double) {
        let idToRotate = ObjectIdentifier(fiziksBody)
        let nodeToRotate = fiziksBodyIdToSKNode[key: idToRotate]
        nodeToRotate?.zRotation += angle
        let fiziksBodyToRotate = fiziksBodyIdToFiziksBody[idToRotate]
        fiziksBodyToRotate?.zRotation += angle
    }

    // Might remove this since FiziksBodies automatically get updated
    func getPosition(of fiziksBody: FiziksBody) -> CGPoint? {
        let bodyId = ObjectIdentifier(fiziksBody)
        let node = fiziksBodyIdToSKNode[key: bodyId]
        return node?.position
    }

    // TODO: its weird to set values like this. Maybe couple the two?
    func setDynamicValue(_ fiziksBody: FiziksBody, to newValue: Bool) {
        fiziksBody.isDynamic = newValue

        let bodyId = ObjectIdentifier(fiziksBody)
        let node = fiziksBodyIdToSKNode[key: bodyId]
        node?.physicsBody?.isDynamic = newValue
    }

    func isDynamic(_ fiziksBody: FiziksBody) -> Bool {
        let bodyId = ObjectIdentifier(fiziksBody)
        let node = fiziksBodyIdToSKNode[key: bodyId]
        return node?.physicsBody?.isDynamic ?? false
    }

    func setUpScene() {
        // TODO: extract out default values
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -1.0)
        self.physicsWorld.contactDelegate = self
        // TODO: why fixed size?
        scene?.size = CGSize(width: 500, height: 500)
        // TODO: whats this?
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
    }

    // FIXME: do the same thing for FiziksShape but for SKPhysicsBody
    private func createSKPhysicsBody(for fiziksBody: FiziksBody) -> SKPhysicsBody? {
        let physicsBody = fiziksBody.fiziksShape.skPhysicsBody
        physicsBody.isDynamic = fiziksBody.isDynamic
        physicsBody.collisionBitMask = fiziksBody.collisionBitMask
        physicsBody.contactTestBitMask = fiziksBody.contactTestBitMask
        // TODO: extract out default values
        physicsBody.friction = 1.0

        return physicsBody
    }

    private func getSKPhysicsBody(of fiziksBody: FiziksBody) -> SKPhysicsBody? {
        let bodyId = ObjectIdentifier(fiziksBody)
        let node = fiziksBodyIdToSKNode[key: bodyId]
        return node?.physicsBody
    }
}

extension FiziksEngine: SKPhysicsContactDelegate {
    // Called when contact between two physics bodies begins in physics world
    public func didBegin(_ contact: SKPhysicsContact) {
        // TODO: Add any logic needed using the two nodes.
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else { return }

        guard let bodyAId = fiziksBodyIdToSKNode[value: nodeA],
              let bodyBId = fiziksBodyIdToSKNode[value: nodeB] else {
            return
        }
        let fiziksBodyA = fiziksBodyIdToFiziksBody[bodyAId]
        let fiziksBodyB = fiziksBodyIdToFiziksBody[bodyBId]
        // print("didBegin")
    }

    // Called when contact between two physics bodies ends in physics world
    public func didEnd(_ contact: SKPhysicsContact) {
        // TODO: Add any logic
        guard let nodeA = contact.bodyA.node,
              let nodeB = contact.bodyB.node else { return }

        guard let bodyAId = fiziksBodyIdToSKNode[value: nodeA],
              let bodyBId = fiziksBodyIdToSKNode[value: nodeB] else {
            return
        }
        let fiziksBodyA = fiziksBodyIdToFiziksBody[bodyAId]
        let fiziksBodyB = fiziksBodyIdToFiziksBody[bodyBId]
        // print("didEnd")
    }
}

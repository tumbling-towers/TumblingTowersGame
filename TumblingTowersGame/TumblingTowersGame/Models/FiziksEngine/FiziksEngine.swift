//
//  Scene.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 9/3/23.
//

import Foundation
import SpriteKit

protocol FiziksEngine: AnyObject {
    var fiziksContactDelegate: FiziksContactDelegate? { get set }

    func insertBounds(_ bounds: CGRect)

    func activatePhysics()

    // FiziksBody related functions
    func contains(_ fiziksBody: FiziksBody) -> Bool
    func add(_ fiziksBody: FiziksBody)
    func delete(_ fiziksBody: FiziksBody)
    func combine(bodyA: FiziksBody, bodyB: FiziksBody, at anchorPoint: CGPoint?)
    func setWorldGravity(to newValue: CGVector)
    func allBodiesContacted(with fiziksBody: FiziksBody) -> [FiziksBody]
    func isIntersecting(body: FiziksBody, otherBodies: [FiziksBody]) -> Bool
    func deleteAllBodies()
    func pause()
    func unpause()
}

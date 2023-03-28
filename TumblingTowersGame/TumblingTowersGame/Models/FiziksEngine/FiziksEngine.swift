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

    // Breaks abstration but this is the only way to start the SKScene
    func activatePhysics()
    func presentOnUselessView(skView: SKView)

    // FiziksBody related functions
    func contains(_ fiziksBody: FiziksBody) -> Bool
    func add(_ fiziksBody: FiziksBody)
    func delete(_ fiziksBody: FiziksBody)
    func combine(_ fiziksBodies: [FiziksBody])
    func setWorldGravity(to newValue: CGVector)
}

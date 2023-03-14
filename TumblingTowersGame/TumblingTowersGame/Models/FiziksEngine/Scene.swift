//
//  Scene.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 9/3/23.
//

import Foundation
import SpriteKit

protocol Scene: SKScene {
    var size: CGSize { get }

    // FiziksBody related functions
    func contains(_ fiziksBody: FiziksBody) -> Bool
    func add(_ fiziksBody: FiziksBody)
    func delete(_ fiziksBody: FiziksBody)
    func move(_ fiziksBody: FiziksBody, to newPosition: CGPoint)
    func move(_ fiziksBody: FiziksBody, by displacement: CGVector)
    func combine(_ fiziksBodies: [FiziksBody])
    func rotate(_ fiziksBody: FiziksBody, by angle: Double)
    func getPosition(of fiziksBody: FiziksBody) -> CGPoint?
    func setDynamicValue(_ fiziksBody: FiziksBody, to newValue: Bool)
    func isDynamic(_ fiziksBody: FiziksBody) -> Bool

    // Scene related functions
    func setUpScene()
}

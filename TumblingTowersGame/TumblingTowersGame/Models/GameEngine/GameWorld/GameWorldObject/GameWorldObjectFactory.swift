//
//  GameWorldObjectFactory.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 9/4/23.
//

import Foundation

class GameWorldObjectFactory {
    static func create<T: GameWorldObject>(ofType gameWorldObjectType: GameWorldObjectType,
                                           ofShape shape: ObjectShape,
                                           at position: CGPoint) -> T? {
        switch gameWorldObjectType {
        case .block:
            guard let pathObjectShape = shape as? PathObjectShape else {
                return nil
            }
            let newFiziksBody = PathFiziksBody(path: pathObjectShape.path,
                                               position: position,
                                               isDynamic: true,
                                               restitution: .zero,
                                               linearDamping: .zero,
                                               categoryBitMask: Block.categoryBitMask,
                                               collisionBitMask: Block.fallingCollisionBitMask,
                                               contactTestBitMask: Block.fallingContactTestBitMask)
            let newBlock = Block(fiziksBody: newFiziksBody, shape: shape)
            return newBlock as? T
        case .platform:
            guard let pathObjectShape = shape as? PathObjectShape else {
                return nil
            }
            let newFiziksBody = PathFiziksBody(path: pathObjectShape.path,
                                               position: position,
                                               zRotation: .zero,
                                               affectedByGravity: false,
                                               isDynamic: false,
                                               restitution: .zero,
                                               categoryBitMask: Platform.categoryBitMask,
                                               collisionBitMask: Platform.collisionBitMask,
                                               contactTestBitMask: Platform.contactTestBitMask)
            let newPlatform = Platform(fiziksBody: newFiziksBody, shape: shape)
            return newPlatform as? T
        case .levelBoundary:
            guard let pathObjectShape = shape as? PathObjectShape else {
                return nil
            }
            let newFiziksBody = PathFiziksBody(path: pathObjectShape.path,
                                               position: position,
                                               isDynamic: false,
                                               categoryBitMask: CategoryMask.levelBoundary,
                                               collisionBitMask: CollisionMask.levelBoundary)
            let newBoundary = LevelBoundary(fiziksBody: newFiziksBody, shape: pathObjectShape)
            return newBoundary as? T
        }
    }
}

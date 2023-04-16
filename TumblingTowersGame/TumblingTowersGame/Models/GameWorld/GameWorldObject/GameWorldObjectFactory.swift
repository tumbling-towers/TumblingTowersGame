//
//  GameWorldObjectFactory.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 9/4/23.
//

import Foundation
import Fiziks

class GameWorldObjectFactory {
    typealias GameWorldObjCreatorClosure = (ObjectShape, CGPoint) -> GameWorldObject?

    private static let gameWorldObjTypeToFn: [String: GameWorldObjCreatorClosure] =
        [GameWorldObjectType.block.rawValue: blockCreator,
         GameWorldObjectType.platform.rawValue: platformCreator,
         GameWorldObjectType.levelBoundary.rawValue: levelBoundaryCreator]

    private static func getSpecificGameWorldObjCreator(from: GameWorldObjectType) -> GameWorldObjCreatorClosure? {
        gameWorldObjTypeToFn[from.rawValue]
    }

    private static let blockCreator: GameWorldObjCreatorClosure = { (_ shape: ObjectShape, _ position: CGPoint)
            -> GameWorldObject? in
        guard let pathObjectShape = shape as? PathObjectShape else {
            return nil
        }
        let newFiziksBody = GameFiziksBody(path: pathObjectShape.path,
                                           position: position,
                                           isDynamic: true,
                                           restitution: .zero,
                                           linearDamping: .zero,
                                           categoryBitMask: Block.categoryBitMask,
                                           collisionBitMask: Block.fallingCollisionBitMask,
                                           contactTestBitMask: Block.fallingContactTestBitMask)
        let newBlock = Block(fiziksBody: newFiziksBody, shape: shape)
        return newBlock
    }

    private static let platformCreator: GameWorldObjCreatorClosure = { (_ shape: ObjectShape, _ position: CGPoint)
            -> GameWorldObject? in
        guard let pathObjectShape = shape as? PathObjectShape else {
            return nil
        }
        let newFiziksBody = GameFiziksBody(path: pathObjectShape.path,
                                           position: position,
                                           zRotation: .zero,
                                           affectedByGravity: false,
                                           isDynamic: false,
                                           restitution: .zero,
                                           categoryBitMask: Platform.categoryBitMask,
                                           collisionBitMask: Platform.collisionBitMask,
                                           contactTestBitMask: Platform.contactTestBitMask)
        let newPlatform = Platform(fiziksBody: newFiziksBody, shape: shape)
        return newPlatform
    }

    private static let levelBoundaryCreator: GameWorldObjCreatorClosure = { (_ shape: ObjectShape, _ position: CGPoint)
            -> GameWorldObject? in
        guard let pathObjectShape = shape as? PathObjectShape else {
            return nil
        }
        let newFiziksBody = GameFiziksBody(path: pathObjectShape.path,
                                           position: position,
                                           isDynamic: false,
                                           categoryBitMask: CategoryMask.levelBoundary,
                                           collisionBitMask: CollisionMask.levelBoundary)
        let newBoundary = LevelBoundary(fiziksBody: newFiziksBody, shape: pathObjectShape)
        return newBoundary
    }

    static func create<T: GameWorldObject>(ofType gameWorldObjectType: GameWorldObjectType,
                                           ofShape shape: ObjectShape,
                                           at position: CGPoint) -> T? {
        let newGameWorldObj = getSpecificGameWorldObjCreator(from: gameWorldObjectType)?.self(shape, position)

        return newGameWorldObj as? T
    }
}

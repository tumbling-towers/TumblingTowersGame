//
//  GameWorldLevel.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 5/4/23.
//

import Foundation

class GameWorldLevel {

    let dimensions: CGRect

    var gameObjects: [any GameWorldObject]

    var blocks: [Block] {
        gameObjects.compactMap({ $0 as? Block })
    }

    var mainPlatform: Platform?

    var powerupLine: PowerupLine?

    var leftBoundary: LevelBoundary?

    var rightBoundary: LevelBoundary?

    var blockInsertionPoint: CGPoint {
        CGPoint(x: dimensions.width / 2,
                y: dimensions.height + 30)
    }

    var outOfBoundsObjects: [GameWorldObject] {
        gameObjects.filter({ isOutOfBounds($0) })
    }

    var blocksInContactWithPowerupLineAndStable: [Block]? {
        guard let powerupLineHeight = powerupLine?.position.y else {
            return nil
        }

        return blocks.filter({ block in isBlockTouchingPowerupLineAndStable(block: block,
                                                                            powerupLineHeight: powerupLineHeight)})
    }

    init(levelDimensions: CGRect) {
        self.dimensions = levelDimensions
        self.gameObjects = []
    }

    func add(gameWorldObject: GameWorldObject) {
        gameObjects.append(gameWorldObject)
    }

    func remove(gameWorldObject: GameWorldObject) {
        gameObjects.removeAll(where: { $0 === gameWorldObject })
    }

    func move(gameWorldObject: GameWorldObject, by vector: CGVector) {
        let fiziksBodyToMove = gameWorldObject.fiziksBody
        let oldPosition = fiziksBodyToMove.position
        let newPosition = CGPoint(x: oldPosition.x + vector.dx,
                                  y: oldPosition.y + vector.dy)
        fiziksBodyToMove.position = newPosition
    }

    func rotate(gameWorldObject: GameWorldObject, by rotation: CGFloat) {
        let fiziksBodyToMove = gameWorldObject.fiziksBody
        fiziksBodyToMove.zRotation += rotation
    }

    func reset() {
        gameObjects = []
        self.mainPlatform = nil
        self.powerupLine = nil
        self.leftBoundary = nil
        self.rightBoundary = nil
    }

    func setMainPlatform(platform: Platform) {
        gameObjects.removeAll(where: { $0 === self.mainPlatform })
        self.mainPlatform = platform
        gameObjects.append(platform)
    }

    func updatePowerupLineHeight() {
        guard let powerupLine = powerupLine else {
            return
        }
        let position = powerupLine.position

        powerupLine.position = position.add(by: CGVector(dx: 0, dy: GameWorldConstants.defaultPowerupHeightStep))
    }

    func isOutOfBounds(_ obj: any GameWorldObject) -> Bool {
        let width = obj.shape.width
        let height = obj.shape.height
        let buffer = max(width, height)
        let pos = obj.position
        // doesn't include being above the level dimensions (so that objects can spawn from above)
        return pos.x - buffer > dimensions.maxX || pos.x + buffer < dimensions.minX || pos.y + buffer < 0
    }

    /// Returns the y-coordinate of the highest point in the level
    func getHighestPoint(excluding excludedObject: GameWorldObject? = nil) -> CGFloat {
        var maxY: Double = -.infinity
        gameObjects.forEach({ obj in
            if let block = obj as? Block,
               block !== excludedObject {
                maxY = max(block.position.y + block.height / 2, maxY)
            }
        })

        return maxY
    }

    private func isBlockTouchingPowerupLineAndStable(block: Block, powerupLineHeight: CGFloat) -> Bool {
        let blockHighestPoint = block.position.y + block.height / 2
        let blockLowestPoint = block.position.y - block.height / 2

        // Stable means velocity = 0
        return blockHighestPoint > powerupLineHeight
            && blockLowestPoint < powerupLineHeight
            && block.fiziksBody.velocity == .zero
    }
}

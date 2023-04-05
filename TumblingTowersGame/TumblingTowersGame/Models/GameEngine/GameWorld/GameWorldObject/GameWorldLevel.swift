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
    
    var platform: Platform?
    
    var powerupLine: PowerupLine?
    
    var leftBoundary: FiziksBody?

    var rightBoundary: FiziksBody?
    
    // TODO: Fix this function - should only be of blocks
    var towerHeight: CGFloat {
        let gameObjectHeights = gameObjects.map({ $0.position.y })
        return gameObjectHeights.max() ?? 0
    }
    
    var blockInsertionPoint: CGPoint {
        CGPoint(x: dimensions.width / 2,
                y: dimensions.height + 30)
    }
    
    init(levelDimensions: CGRect) {
        self.dimensions = levelDimensions
        self.gameObjects = []
    }
    
    func reset() {
        gameObjects = []
        self.platform = nil
        self.powerupLine = nil
        self.leftBoundary = nil
        self.rightBoundary = nil
    }
    
    func setMainPlatform(platform: Platform) {
        gameObjects.removeAll(where: { $0 === self.platform })
        self.platform = platform
        gameObjects.append(platform)
    }
    
    func updatePowerupLineHeight() {
        guard let powerupLine = powerupLine else { return }
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
}

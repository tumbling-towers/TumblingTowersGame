//
//  ViewAdapater.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 14/4/23.
//

import Foundation
import SwiftUI
import SpriteKit

class ViewAdapter: GameRendererDelegate, ObservableObject {
    @Published var goalLinePosition = CGPoint()
    @Published var powerUpLinePosition = CGPoint()
    @Published var powerupLineDimensions = CGSize()
    @Published var levelBlocks: [GameObjectBlock] = []
    @Published var levelPlatforms: [GameObjectPlatform] = []
    @Published var powerups: [Powerup.Type?] = [Powerup.Type?](repeating: nil, count: 5)
    @Published var achievements: [DisplayableAchievement] = []
    
    var levelDimensions: CGRect
    var gameEngineMgr: GameEngineManager
    
    @Published var gameMode: GameMode?
    @Published var timeRemaining: Int = 0
    @Published var score: Int = 0
    @Published var gameEnded: Bool = true
    @Published var gameEndMainMessage: String = ""
    @Published var gameEndSubMessage: String = ""
    
    init(levelDimensions: CGRect, gameEngineMgr: GameEngineManager) {
        self.levelDimensions = levelDimensions
        self.gameEngineMgr = gameEngineMgr
    }
    
    func dragEvent(offset: CGSize) {
        gameEngineMgr.dragEvent(offset: offset)
    }
    
    var referenceBox: CGRect?
    
    func renderCurrentFrame(gameObjects: [any GameWorldObject], powerUpLine: PowerupLine) {
        let levelToRender = convertLevel(gameObjects: gameObjects)
        renderLevel(gameObjectBlocks: levelToRender.blocks, gameObjectPlatforms: levelToRender.platforms, powerupLine: powerUpLine)
        rerender()
    }

    /// GameEngine outputs coordinates with the origin at the bottom-left.
    /// This method converts it such that the origin is at the top-left.
    private func adjustCoordinates(for point: CGPoint) -> CGPoint {
        let newPoint = CGPoint(x: point.x, y: levelDimensions.height - point.y)
        return newPoint
    }

    private func transformRenderable(for block: GameObjectBlock) -> GameObjectBlock {
        // Flips the block vertically (mirror image) due to difference in coordinate system
        let path = transformPath(path: block.path, width: block.width, height: block.height)
        let newPosition = adjustCoordinates(for: block.position)
        // TODO: Don't return a new block
        let transformedBlock = GameObjectBlock(position: newPosition, path: path, specialProperties: block.specialProperties)
        return transformedBlock
    }
    
    private func convertLevel(gameObjects: [any GameWorldObject]) -> Level {
        var blocks: [GameObjectBlock] = []
        var platforms: [GameObjectPlatform] = []
        
        for object in gameObjects {
            if type(of: object) == Block.self {
                guard let block = object as? Block, let tetrisShape = block.shape as? TetrisShape else { continue }
                blocks.append(GameObjectBlock(position: block.position, path: tetrisShape.path, rotation: block.rotation, specialProperties: block.specialProperties))
            } else if type(of: object) == Platform.self {
                guard object is Platform else { continue }
                platforms.append(GameObjectPlatform(position: object.position, width: object.width, height: object.height))
            }
        }
        
        return Level(blocks: blocks, platforms: platforms)
    }

    private func transformPath(path: CGPath, width: Double, height: Double) -> CGPath {
        let path = UIBezierPath(cgPath: path)
        var flip = CGAffineTransformMakeScale(1, -1)
        flip = CGAffineTransformTranslate(flip, width / 2, -height / 2)
        path.apply(flip)
        return path.cgPath
    }
    
    func rerender() {
//        objectWillChange.send()
    }

    func getCurrInput() -> InputData {
        return .none
    }
    
    func rotateCurrentBlock() {
        gameEngineMgr.rotateCurrentBlock()
    }
    
    func resetInput() {
        gameEngineMgr.resetInput()
    }

    func resetGame() {
        gameEngineMgr.resetGame()
    }

    func startGame(gameMode: Constants.GameModeTypes) {
        gameEngineMgr.startGame(gameMode: gameMode)
    }
    
    func getPhysicsEngine() -> FiziksEngine {
        gameEngineMgr.getPhysicsEngine()
    }

    
    func renderLevel(gameObjectBlocks: [GameObjectBlock], gameObjectPlatforms: [GameObjectPlatform], powerupLine: PowerupLine) {
        var invertedGameObjBlocks: [GameObjectBlock] = []
        var invertedGameObjPlatforms: [GameObjectPlatform] = []

        for gameObjectBlock in gameObjectBlocks {
            let transformedBlock = transformRenderable(for: gameObjectBlock)
            invertedGameObjBlocks.append(transformedBlock)
        }

        for var platform in gameObjectPlatforms {
            let transformedPlatformPosition = adjustCoordinates(for: platform.position)
            platform.position = transformedPlatformPosition
            invertedGameObjPlatforms.append(platform)
        }

        if powerupLine != nil {
            powerUpLinePosition = adjustCoordinates(for: powerupLine.position)
                                  .add(by: CGVector(dx: -powerupLineDimensions.width / 2,
                                                    dy: 0))
            powerupLineDimensions = CGSize(width: powerupLine.dimensions.width, height: powerupLine.dimensions.height)
        }

        self.levelBlocks = invertedGameObjBlocks
        self.levelPlatforms = invertedGameObjPlatforms
    }

}
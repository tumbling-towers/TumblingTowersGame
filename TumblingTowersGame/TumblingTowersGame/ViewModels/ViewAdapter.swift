//
//  ViewAdapater.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 14/4/23.
//

import Foundation
import SwiftUI
import SpriteKit
import Fiziks

class ViewAdapter: GameRendererDelegate, ObservableObject {
    @Published var powerUpLinePosition = CGPoint()
    @Published var powerupLineDimensions = CGSize()
    @Published var levelBlocks: [GameObjectBlock] = []
    @Published var levelPlatforms: [GameObjectPlatform] = []
    @Published var powerups: [Powerup.Type?] = [Powerup.Type?](repeating: nil, count: 5)

    var levelDimensions: CGRect
    var gameEngineMgr: GameEngineManager

    @Published var gameMode: GameMode?
    @Published var timeRemaining: Int = 0
    @Published var score: Int = 0
    @Published var gameEnded = true
    @Published var gameEndMainMessage: String = ""
    @Published var gameEndSubMessage: String = ""

    init(levelDimensions: CGRect, gameEngineMgr: GameEngineManager) {
        self.levelDimensions = levelDimensions
        self.gameEngineMgr = gameEngineMgr
        gameEngineMgr.setRendererDelegate(self)
    }

    func dragEvent(offset: CGSize) {
        gameEngineMgr.dragEvent(offset: CGSize(width: offset.width, height: -offset.height))
    }

    @Published var referenceBox: CGRect = .infinite

    func updateViewVariables(referenceBoxToUpdate: CGRect,
                             powerupsToUpdate: [Powerup.Type?],
                             gameModeToUpdate: GameMode,
                             timeRemainingToUpdate: Int,
                             scoreToUpdate: Int,
                             gameEndedToUpdate: Bool,
                             gameEndMainMessageToUpdate: String,
                             gameEndSubMessageToUpdate: String) {
        referenceBox = referenceBoxToUpdate
        powerups = powerupsToUpdate

        gameMode = gameModeToUpdate
        timeRemaining = timeRemainingToUpdate
        score = scoreToUpdate
        gameEndSubMessage = gameEndSubMessageToUpdate
        gameEndMainMessage = gameEndMainMessageToUpdate
    }

    func renderCurrentFrame(gameObjects: [any GameWorldObject], powerUpLine: PowerupLine) {

        let levelToRender = convertLevel(gameObjects: gameObjects)
        renderLevel(gameObjectBlocks: levelToRender.blocks,
                    gameObjectPlatforms: levelToRender.platforms,
                    powerupLine: powerUpLine)
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
        let transformedBlock = GameObjectBlock(position: newPosition,
                                               path: path,
                                               specialProperties: block.specialProperties)
        return transformedBlock
    }

    private func convertLevel(gameObjects: [any GameWorldObject]) -> Level {
        var blocks: [GameObjectBlock] = []
        var platforms: [GameObjectPlatform] = []

        for object in gameObjects {
            if type(of: object) == Block.self {
                guard let block = object as? Block, let tetrisShape = block.shape as? TetrisShape else { continue }
                blocks.append(GameObjectBlock(position: block.position,
                                              path: tetrisShape.path,
                                              rotation: block.rotation,
                                              specialProperties: block.specialProperties))
            } else if type(of: object) == Platform.self {
                guard object is Platform else { continue }
                platforms.append(GameObjectPlatform(position: object.position,
                                                    width: object.width,
                                                    height: object.height))
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
        objectWillChange.send()
    }

    func getCurrInput() -> InputData {
        .none
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
        gameEngineMgr.physicsEngine
    }

    func renderLevel(gameObjectBlocks: [GameObjectBlock],
                     gameObjectPlatforms: [GameObjectPlatform],
                     powerupLine: PowerupLine) {
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

        powerUpLinePosition = adjustCoordinates(for: powerupLine.position)
            .add(by: CGVector(dx: -powerupLineDimensions.width / 2,
                              dy: 0))
        powerupLineDimensions = CGSize(width: powerupLine.dimensions.width, height: powerupLine.dimensions.height)

        self.levelBlocks = invertedGameObjBlocks
        self.levelPlatforms = invertedGameObjPlatforms
    }

    func usePowerup(at idx: Int) {
        gameEngineMgr.usePowerup(at: idx)
    }

    func getUpdatedAchievements() -> [DisplayableAchievement] {
        let storage = gameEngineMgr.storageManager
        let statsSystem = StatsTrackingSystem(eventManager: TumblingTowersEventManager(), storageManager: storage)
        let achievementSystem = AchievementSystem(eventManager: TumblingTowersEventManager(),
                                                  dataSource: statsSystem,
                                                  storageManager: storage)

        let updatedAchievements = achievementSystem.calculateAndGetUpdatedAchievements()

        let displayableAchievements = convertToRenderableAchievement(achievements: updatedAchievements)

        return displayableAchievements
    }

    private func convertToRenderableAchievement(achievements: [any Achievement]) -> [DisplayableAchievement] {
        var displayableAchievements = [DisplayableAchievement]()
        for achievement in achievements {
            let displayableAchievement = DisplayableAchievement(id: UUID(),
                                                                name: achievement.name,
                                                                description: achievement.description,
                                                                goal: achievement.goal,
                                                                achieved: achievement.achieved)
            displayableAchievements.append(displayableAchievement)
        }
        return displayableAchievements
    }

}

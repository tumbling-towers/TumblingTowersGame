//
//  GameEngine.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 5/4/23.
//

import Foundation

class GameEngine {
    let eventManager: EventManager
    let gameWorld: GameWorld
    let achiementSystem: AchievementSystem
    let statsTrackingSystem: StatsTrackingSystem
    var gameMode: GameMode?
    var level: GameWorldLevel {
        gameWorld.level
    }
    
    init(levelDimensions: CGRect, eventManager: EventManager) {
        self.gameWorld = GameWorld(levelDimensions: levelDimensions, eventManager: eventManager)
        self.eventManager = eventManager
        let statsTrackingSystem = StatsTrackingSystem(eventManager: eventManager)
        self.statsTrackingSystem = statsTrackingSystem
        self.achiementSystem = AchievementSystem(eventManager: eventManager, dataSource: statsTrackingSystem)
    }
    
    func startGame() {
        gameWorld.startGame()
        gameMode?.startGame()
    }
    
    func update() {
        // TODO: Support this by adding function ins Gamemode
        gameMode?.update()
        gameWorld.update()
    }
    
    func stopGame() {
        gameWorld.endGame()
        gameMode?.endGame()
    }
    
    func pauseGame() {
        gameWorld.pauseGame()
    }
    
    func unpauseGame() {
        gameWorld.unpauseGame()
    }
    
    func resetGame() {
        gameWorld.resetGame()
        gameMode?.resetGame()
    }
    
    // MARK: Game Control methods
    /// Slides the currently-moving block only on the x-axis.
    func moveCMBSideways(by displacement: CGVector) {
        let correctedDisplacement = CGVector(dx: displacement.dx, dy: 0)
        gameWorld.moveCMB(by: correctedDisplacement)
    }

    /// Moves the currently-moving block downwards only.
    func moveCMBDown(by displacement: CGVector) {
        let correctedDy = min(displacement.dy, 0)
        let correctedDisplacement = CGVector(dx: 0, dy: correctedDy)
        gameWorld.moveCMB(by: correctedDisplacement)
    }

    /// Rotates the currently moving block clockwise by 90 degrees.
    func rotateCMBClockwise() {
        gameWorld.rotateCMB(by: -CGFloat.pi / 2)
    }

    /// Rotates the currently moving block counter-clockwise by 90 degrees.
    func rotateCMBCounterClockwise() {
        gameWorld.rotateCMB(by: CGFloat.pi / 2)
    }
    
}

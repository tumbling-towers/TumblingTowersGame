//
//  GameplayLevelView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 15/3/23.
//

import SpriteKit
import SwiftUI

struct GameplayLevelView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    
    var body: some View {

        // Need to run physics engine (from testing we need to run these 2 lines so that the physics engine will start running)
//        skView.presentScene(gameEngine?.fiziksEngine)
//        skView.showsPhysics = true

        SpriteView(scene: getUselessSKSceneToPresent())
//        TestView()
        LevelView()
    }

    private func getUselessSKSceneToPresent() -> SKScene {
        // Equivalent to gameEngine?.fiziksEngine
        guard let gameFiziksEngine = gameEngineMgr.getPhysicsEngine() as? GameFiziksEngine else {
            // TODO: throw error
            return SKScene()
        }
        gameFiziksEngine.activatePhysics()
        return gameFiziksEngine.fiziksScene
    }
}

struct GameplayLevelView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayLevelView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}

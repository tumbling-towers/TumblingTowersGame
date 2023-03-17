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
    }

    private func getUselessSKSceneToPresent() -> SKScene {
        // Equivalent to gameEngine?.fiziksEngine
        // let skScene = gameEngineMgr.getPhysicsEngine()
        let skScene = SKScene()

        // Not sure if this works
        // skScene.view?.showsPhysics = true

        return skScene
    }
}

struct GameplayLevelView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayLevelView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}

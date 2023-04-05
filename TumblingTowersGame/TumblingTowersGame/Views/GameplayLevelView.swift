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
    
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
//        LevelView()
        // sprite view required for sprite kit to run, hidden
        SpriteView(scene: getUselessSKSceneToPresent())

        // present actual level rendered by swift ui above sprite view
        LevelView(currGameScreen: $currGameScreen)
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
        GameplayLevelView(currGameScreen: .constant(.gameplay))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
    }
}

//
//  GameplayLevelView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 15/3/23.
//

import SpriteKit
import SwiftUI

struct GameplayLevelView: View {
    @Binding var currGameScreen: Constants.CurrGameScreens
    @StateObject var gameEngineMgr: GameEngineManager
    @State var gameMode: Constants.GameModeTypes

    var body: some View {
//        LevelView()
        // sprite view required for sprite kit to run, hidden
        SpriteView(scene: getUselessSKSceneToPresent())

        // present actual level rendered by swift ui above sprite view
        LevelView(currGameScreen: $currGameScreen)
        .environmentObject(gameEngineMgr)
        .onAppear(perform: {
            gameEngineMgr.startGame(gameMode: gameMode)
        })
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
        GameplayLevelView(currGameScreen: .constant(.singleplayerGameplay), gameEngineMgr: GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()), gameMode: .SANDBOX)
    }
}

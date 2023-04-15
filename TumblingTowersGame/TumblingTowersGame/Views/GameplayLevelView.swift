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
    
    // for tracking drag movement
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            // sprite view required for sprite kit to run, hidden
            SpriteView(scene: getUselessSKSceneToPresent())

            // present actual level rendered by swift ui above sprite view
            LevelView(currGameScreen: $currGameScreen)
            .environmentObject(gameEngineMgr)
            .onAppear(perform: {
                gameEngineMgr.startGame(gameMode: gameMode)
            })
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    offset = gesture.translation
                    gameEngineMgr.dragEvent(offset: offset)
                }
                .onEnded { _ in
                    offset = .zero
                    gameEngineMgr.resetInput()
                }
            )
        }
    }

    private func getUselessSKSceneToPresent() -> SKScene {
        // Equivalent to gameEngine?.fiziksEngine
        guard let gameFiziksEngine = gameEngineMgr.physicsEngine as? GameFiziksEngine else {
            return SKScene()
        }
        return gameFiziksEngine.fiziksScene
    }
}

struct GameplayLevelView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayLevelView(currGameScreen: .constant(.singleplayerGameplay), gameEngineMgr: GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), inputType: TapInput.self, storageManager: StorageManager()), gameMode: .SANDBOX)
    }
}

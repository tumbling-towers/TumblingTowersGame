//
//  GameplayLevelView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 15/3/23.
//

import SpriteKit
import SwiftUI
import Fiziks

struct GameplayLevelView: View {
    @Binding var currGameScreen: Constants.CurrGameScreens
    @StateObject var viewAdapter: ViewAdapter
    @State var gameMode: Constants.GameModeTypes

    // for tracking drag movement
    @State private var offset = CGSize.zero

    var body: some View {
        ZStack {
            // sprite view required for sprite kit to run, hidden
            SpriteView(scene: getUselessSKSceneToPresent())

            // present actual level rendered by swift ui above sprite view
            LevelView(currGameScreen: $currGameScreen)
            .environmentObject(viewAdapter)
            .onAppear(perform: {
                viewAdapter.startGame(gameMode: gameMode)
            })
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    offset = gesture.translation
                    viewAdapter.dragEvent(offset: offset)
                }
                .onEnded { _ in
                    offset = .zero
                    viewAdapter.resetInput()
                }
            )
        }
    }

    private func getUselessSKSceneToPresent() -> SKScene {
        // Equivalent to gameEngine?.fiziksEngine
        guard let gameFiziksEngine = viewAdapter.getPhysicsEngine() as? GameFiziksEngine else {
            assert(false)
        }
        return gameFiziksEngine.fiziksScene
    }
}

struct GameplayLevelView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayLevelView(currGameScreen: .constant(.singleplayerGameplay),
                          viewAdapter: (ViewAdapter(levelDimensions: .infinite,
                                                    gameEngineMgr: GameInstanceController(
                                                        levelDimensions: .infinite,
                                                        eventManager: TumblingTowersEventManager(),
                                                        inputType: TapInput.self,
                                                        storageManager: StorageManager(),
                                                        playersMode: .singleplayer))),
                          gameMode: .SANDBOX)
    }
}

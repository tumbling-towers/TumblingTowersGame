//
//  ContentView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 14/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager

    @StateObject var gameEngineMgr: GameEngineManager
    @State var currGameScreen = Constants.CurrGameScreens.mainMenu

    // for tracking drag movement
    @State private var offset = CGSize.zero

    var body: some View {

        ZStack {
            if currGameScreen == .mainMenu {
                MainMenuView(currGameScreen: $currGameScreen)
                    .environmentObject(mainGameMgr)
                    .environmentObject(gameEngineMgr)
            } else if currGameScreen == .gameModeSelection {
                GameModeSelectView(currGameScreen: $currGameScreen)
                    .environmentObject(gameEngineMgr)
            } else if currGameScreen == .gameplay {
                ZStack {
                    GameplayLevelView(currGameScreen: $currGameScreen)
                        .environmentObject(gameEngineMgr)
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
                .ignoresSafeArea(.all)
            } else if currGameScreen == .settings {
                SettingsView(settingsMgr: SettingsManager(), currGameScreen: $currGameScreen)
                    .environmentObject(mainGameMgr)
                    .environmentObject(gameEngineMgr)
            } else if currGameScreen == .achievements {
                ZStack {
                    BackgroundView()
                    GameplayGoBackMenuView(currGameScreen: $currGameScreen)
                        .environmentObject(gameEngineMgr)
                }
            }
            
            if gameEngineMgr.gameEnded {
                GameEndView(currGameScreen: $currGameScreen)
                    .environmentObject(gameEngineMgr)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var mainGameMgrPrev = MainGameManager()

    static var previews: some View {
        ContentView(gameEngineMgr: GameEngineManager(levelDimensions: .infinite,
                                                     eventManager: TumblingTowersEventManager()))
            .environmentObject(mainGameMgrPrev)
    }
}

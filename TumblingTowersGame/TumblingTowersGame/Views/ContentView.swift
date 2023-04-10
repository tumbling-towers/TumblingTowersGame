//
//  ContentView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 14/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager

    @State var deviceHeight: Double
    @State var deviceWidth: Double
    @State var currGameScreen = Constants.CurrGameScreens.mainMenu

    // for tracking drag movement
    @State private var offset = CGSize.zero

    var body: some View {

        ZStack {
            if currGameScreen == .mainMenu {
                MainMenuView(currGameScreen: $currGameScreen)
                    .environmentObject(mainGameMgr)
            } else if currGameScreen == .gameModeSelection {
                GameModeSelectView(currGameScreen: $currGameScreen)
            } else if currGameScreen == .singleplayerGameplay, let gameMode = mainGameMgr.gameMode {
                ZStack {
                    GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight, width: deviceWidth), gameMode: gameMode)
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                offset = gesture.translation
                                mainGameMgr.dragEvent(offset: offset)
                            }
                            .onEnded { _ in
                                offset = .zero
                                mainGameMgr.resetInput()
                            }
                        )
                }
                .ignoresSafeArea(.all)
            } else if currGameScreen == .multiplayerGameplay, let gameMode = mainGameMgr.gameMode {
                VStack {
                    GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth), gameMode: gameMode)
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                offset = gesture.translation
                                mainGameMgr.dragEvent(offset: offset)
                            }
                            .onEnded { _ in
                                offset = .zero
                                mainGameMgr.resetInput()
                            }
                        )
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                    GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth), gameMode: gameMode)
                        .gesture(DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                offset = gesture.translation
                                mainGameMgr.dragEvent(offset: offset)
                            }
                            .onEnded { _ in
                                offset = .zero
                                mainGameMgr.resetInput()
                            }
                        )
                }
            } else if currGameScreen == .settings {
                SettingsView(settingsMgr: SettingsManager(), currGameScreen: $currGameScreen)
                    .environmentObject(mainGameMgr)
            } else if currGameScreen == .achievements {
                ZStack {
                    BackgroundView()
                    // TODO: Change this
                    //                    GameplayGoBackMenuView(currGameScreen: $currGameScreen)
                    //                        .environmentObject(gameEngineMgr)
                }
            } else if currGameScreen == .playerOptionSelection {
                ZStack {
                    PlayersSelectView(currGameScreen: $currGameScreen)
                }
            }
            
            
            // TODO: Check if this works correctly
            if mainGameMgr.playersMode == .singleplayer {
                if mainGameMgr.gameEngineMgrs.count == 1,
                   let gameEngineMgr = mainGameMgr.gameEngineMgrs[0],
                   gameEngineMgr.gameState != nil && gameEngineMgr.gameState != .RUNNING && gameEngineMgr.gameState != .PAUSED {
                            GameEndView(currGameScreen: $currGameScreen)
                                .environmentObject(gameEngineMgr)
                }
            } else if mainGameMgr.playersMode == .multiplayer {
                if mainGameMgr.gameEngineMgrs.count == 2,
                   let gameEngineMgr = mainGameMgr.gameEngineMgrs[0],
                   let gameEngineMgr2 = mainGameMgr.gameEngineMgrs[1],
                   gameEngineMgr.gameState != nil && gameEngineMgr.gameState != .RUNNING && gameEngineMgr.gameState != .PAUSED {
                    VStack {
                        GameEndView(currGameScreen: $currGameScreen)
                            .environmentObject(gameEngineMgr)
                        GameEndView(currGameScreen: $currGameScreen)
                            .environmentObject(gameEngineMgr2)
                    }
                }
            }
            

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var mainGameMgrPrev = MainGameManager()

    static var previews: some View {
        ContentView(deviceHeight: .infinity, deviceWidth: .infinity)
            .environmentObject(mainGameMgrPrev)
    }
}

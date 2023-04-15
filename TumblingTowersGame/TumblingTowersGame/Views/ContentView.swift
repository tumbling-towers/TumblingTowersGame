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

    var body: some View {

        ZStack {
            if currGameScreen == .mainMenu {
                MainMenuView(currGameScreen: $currGameScreen)
                    .environmentObject(mainGameMgr)
            } else if currGameScreen == .gameModeSelection {
                GameModeSelectView(currGameScreen: $currGameScreen)
            } else if currGameScreen == .singleplayerGameplay,
                      let gameMode = mainGameMgr.gameMode {
                
                let gameEngineMgr = mainGameMgr.createGameEngineManager(height: deviceHeight, width: deviceWidth)
                let viewAdapter = ViewAdapter(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), gameEngineMgr: gameEngineMgr)
                
                ZStack {
                    GameplayLevelView(currGameScreen: $currGameScreen, viewAdapter: viewAdapter, gameMode: gameMode)
                }
                .onAppear {
                    gameEngineMgr.setRendererDelegate(viewAdapter)
                }
                .ignoresSafeArea(.all)
            } else if currGameScreen == .multiplayerGameplay,
                      let gameMode = mainGameMgr.gameMode {
                      
                  let gameEngineMgr = mainGameMgr.createGameEngineManager(height: deviceHeight, width: deviceWidth)
                  let viewAdapter = ViewAdapter(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), gameEngineMgr: gameEngineMgr)
                  let gameEngineMgr2 = mainGameMgr.createGameEngineManager(height: deviceHeight, width: deviceWidth)
                  let viewAdapter2 = ViewAdapter(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), gameEngineMgr: gameEngineMgr2)
                
                VStack {
                    GameplayLevelView(currGameScreen: $currGameScreen, viewAdapter: viewAdapter, gameMode: gameMode)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                    GameplayLevelView(currGameScreen: $currGameScreen, viewAdapter: viewAdapter2, gameMode: gameMode)
                }
                .onAppear {
                    gameEngineMgr.setRendererDelegate(viewAdapter)
                    gameEngineMgr2.setRendererDelegate(viewAdapter2)
                }
            } else if currGameScreen == .settings {
                SettingsView(settingsMgr: SettingsManager(), currGameScreen: $currGameScreen, selectedInputType: mainGameMgr.inputSystem)
                    .environmentObject(mainGameMgr)
            } else if currGameScreen == .achievements {
                let gameEngineMgr = GameEngineManager(levelDimensions: CGRect(x: 0, y: 0, width: mainGameMgr.deviceWidth, height: mainGameMgr.deviceHeight), eventManager: TumblingTowersEventManager(), inputType: TapInput.self, storageManager: mainGameMgr.storageManager)
                  let viewAdapter = ViewAdapter(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), gameEngineMgr: gameEngineMgr)
                
                AchievementsView(currGameScreen: $currGameScreen)
                    .environmentObject(viewAdapter)
                    .onAppear {
                        gameEngineMgr.setRendererDelegate(viewAdapter)
                    }
            } else if currGameScreen == .playerOptionSelection {
                ZStack {
                    PlayersSelectView(currGameScreen: $currGameScreen)
                }
            } else if currGameScreen == .tutorial {
                TutorialView(currGameScreen: $currGameScreen)
            }

            drawGameEndScreens()

        }
    }

    private func drawGameEndScreens() -> AnyView {
        AnyView(
            ZStack {
//                if mainGameMgr.playersMode == .singleplayer, mainGameMgr.countGEM() {
//                    if mainGameMgr.gameEngineMgrs.count >= 1,
//                       let gameEngineMgr = mainGameMgr.gameEngineMgrs[0],
//                       gameEngineMgr.gameEnded {
//
//                        let viewAdapter = ViewAdapter(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), gameEngineMgr: gameEngineMgr)
//
//                                GameEndView(currGameScreen: $currGameScreen)
//                                    .environmentObject(viewAdapter)
//                    }
//                } else if mainGameMgr.playersMode == .multiplayer {
//                    if mainGameMgr.gameEngineMgrs.count == 2,
//                       let gameEngineMgr = mainGameMgr.gameEngineMgrs[0],
//                       let gameEngineMgr2 = mainGameMgr.gameEngineMgrs[1],
//                       gameEngineMgr.gameEnded {
//
//                        let viewAdapter = ViewAdapter(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), gameEngineMgr: gameEngineMgr)
//                        let viewAdapter2 = ViewAdapter(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth, height: deviceHeight), gameEngineMgr: gameEngineMgr2)
//
//                        VStack {
//                            GameEndView(currGameScreen: $currGameScreen)
//                                .environmentObject(viewAdapter)
//                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
//                            GameEndView(currGameScreen: $currGameScreen)
//                                .environmentObject(viewAdapter2)
//                        }
//                    }
//                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var mainGameMgrPrev = MainGameManager()

    static var previews: some View {
        ContentView(deviceHeight: .infinity, deviceWidth: .infinity)
            .environmentObject(mainGameMgrPrev)
    }
}

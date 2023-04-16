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

                ZStack {
                    GameplayLevelView(currGameScreen: $currGameScreen,
                                      viewAdapter: ViewAdapter(levelDimensions: CGRect(x: 0,
                                                                                       y: 0,
                                                                                       width: deviceWidth,
                                                                                       height: deviceHeight),
                                                               gameEngineMgr: mainGameMgr
                                        .createGameEngineManager(height: deviceHeight,
                                                                 width: deviceWidth)),
                                      gameMode: gameMode)
                }
                .ignoresSafeArea(.all)
            } else if currGameScreen == .multiplayerGameplay,
                      let gameMode = mainGameMgr.gameMode {

                VStack {
                    GameplayLevelView(currGameScreen: $currGameScreen,
                                      viewAdapter: ViewAdapter(levelDimensions: CGRect(x: 0,
                                                                                       y: 0,
                                                                                       width: deviceWidth,
                                                                                       height: deviceHeight / 2),
                                                               gameEngineMgr: mainGameMgr
                                        .createGameEngineManager(height: deviceHeight / 2,
                                                                 width: deviceWidth)),
                                      gameMode: gameMode)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                    GameplayLevelView(currGameScreen: $currGameScreen,
                                      viewAdapter: ViewAdapter(levelDimensions: CGRect(x: 0, y: 0, width: deviceWidth,
                                                                                       height: deviceHeight / 2),
                                                               gameEngineMgr: mainGameMgr
                                        .createGameEngineManager(height: deviceHeight / 2,
                                                                 width: deviceWidth)),
                                      gameMode: gameMode)
                }
            } else if currGameScreen == .settings {
                SettingsView(settingsMgr: SettingsManager(),
                             currGameScreen: $currGameScreen,
                             selectedInputType: mainGameMgr.inputSystem)
                .environmentObject(mainGameMgr)
            } else if currGameScreen == .achievements {

                AchievementsView(currGameScreen: $currGameScreen)

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
                if mainGameMgr.playersMode == .singleplayer, mainGameMgr.countGEM() {
                    if mainGameMgr.gameEngineMgrs.count >= 1,
                       mainGameMgr.gameEngineMgrs[0].gameEnded {
                        GameEndView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.gameEngineMgrs[0])
                    }
                } else if mainGameMgr.playersMode == .multiplayer {
                    if mainGameMgr.countGEM(),
                       mainGameMgr.gameEngineMgrs.count == 2,
                       mainGameMgr.gameEngineMgrs[0].gameEnded {
                        VStack {
                            GameEndView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.gameEngineMgrs[0])
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            GameEndView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.gameEngineMgrs[1])
                        }
                    }
                }
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

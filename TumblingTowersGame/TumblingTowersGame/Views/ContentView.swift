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
            } else if currGameScreen == .singleplayerGameplay, let gameMode = mainGameMgr.gameMode {
                ZStack {
                    GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight, width: deviceWidth), gameMode: gameMode)
                }
                .ignoresSafeArea(.all)
            } else if currGameScreen == .multiplayerGameplay, let gameMode = mainGameMgr.gameMode {
                VStack {
                    GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth), gameMode: gameMode)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                    GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth), gameMode: gameMode)
                }
            } else if currGameScreen == .threeplayerGameplay, let gameMode = mainGameMgr.gameMode {
                VStack {
                    HStack {
                        GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth / 2), gameMode: gameMode)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            .frame(width: deviceWidth / 2, height: deviceHeight / 2, alignment: .trailing)

                        GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth / 2), gameMode: gameMode)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            .frame(width: deviceWidth / 2, height: deviceHeight / 2, alignment: .trailing)
                    }

                    HStack {
                        GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth), gameMode: gameMode)
                    }
                }
            } else if currGameScreen == .fourplayerGameplay, let gameMode = mainGameMgr.gameMode {
                VStack {
                    HStack {
                        GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth / 2), gameMode: gameMode)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            .frame(width: deviceWidth / 2, height: deviceHeight / 2, alignment: .trailing)

                        GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth / 2), gameMode: gameMode)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            .frame(width: deviceWidth / 2, height: deviceHeight / 2, alignment: .trailing)
                    }

                    HStack {
                        GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth / 2), gameMode: gameMode)
                            .frame(width: deviceWidth / 2, height: deviceHeight / 2, alignment: .trailing)

                        GameplayLevelView(currGameScreen: $currGameScreen, gameEngineMgr: mainGameMgr.createGameEngineManager(height: deviceHeight / 2, width: deviceWidth / 2), gameMode: gameMode)
                            .frame(width: deviceWidth / 2, height: deviceHeight / 2, alignment: .trailing)
                    }
                }
            } else if currGameScreen == .settings {
                SettingsView(settingsMgr: SettingsManager(), currGameScreen: $currGameScreen, selectedInputType: mainGameMgr.inputSystem)
                    .environmentObject(mainGameMgr)
            } else if currGameScreen == .achievements {
                AchievementsView(currGameScreen: $currGameScreen)
                    .environmentObject(GameEngineManager(levelDimensions: CGRect(x: 0, y: 0, width: mainGameMgr.deviceWidth, height: mainGameMgr.deviceHeight), eventManager: TumblingTowersEventManager(), inputType: TapInput.self, storageManager: mainGameMgr.storageManager))
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
                       let gameEngineMgr = mainGameMgr.gameEngineMgrs[0],
                       gameEngineMgr.gameEnded {
                                GameEndView(currGameScreen: $currGameScreen)
                                    .environmentObject(gameEngineMgr)
                    }
                } else if mainGameMgr.playersMode == .multiplayer {
                    if mainGameMgr.gameEngineMgrs.count == 2,
                       let gameEngineMgr = mainGameMgr.gameEngineMgrs[0],
                       let gameEngineMgr2 = mainGameMgr.gameEngineMgrs[1],
                       gameEngineMgr.gameEnded {
                        VStack {
                            GameEndView(currGameScreen: $currGameScreen)
                                .environmentObject(gameEngineMgr)
                                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            GameEndView(currGameScreen: $currGameScreen)
                                .environmentObject(gameEngineMgr2)
                        }
                    }
                } else if mainGameMgr.playersMode == .threeplayer {
                    if mainGameMgr.gameEngineMgrs.count == 3,
                       let gameEngineMgr = mainGameMgr.gameEngineMgrs[0],
                       let gameEngineMgr2 = mainGameMgr.gameEngineMgrs[1],
                       let gameEngineMgr3 = mainGameMgr.gameEngineMgrs[2],
                       gameEngineMgr.gameEnded {
                        VStack {
                            HStack {
                                GameEndView(currGameScreen: $currGameScreen)
                                    .environmentObject(gameEngineMgr)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                                GameEndView(currGameScreen: $currGameScreen)
                                    .environmentObject(gameEngineMgr2)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            }

                            HStack {
                                GameEndView(currGameScreen: $currGameScreen)
                                    .environmentObject(gameEngineMgr3)
                            }
                        }
                    }
                } else if mainGameMgr.playersMode == .fourplayer {
                    if mainGameMgr.gameEngineMgrs.count == 4,
                       let gameEngineMgr = mainGameMgr.gameEngineMgrs[0],
                       let gameEngineMgr2 = mainGameMgr.gameEngineMgrs[1],
                       let gameEngineMgr3 = mainGameMgr.gameEngineMgrs[2],
                       let gameEngineMgr4 = mainGameMgr.gameEngineMgrs[3],
                       gameEngineMgr.gameEnded {
                        VStack {
                            HStack {
                                GameEndView(currGameScreen: $currGameScreen)
                                    .environmentObject(gameEngineMgr)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                                GameEndView(currGameScreen: $currGameScreen)
                                    .environmentObject(gameEngineMgr2)
                                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 0, z: 1))
                            }

                            HStack {
                                GameEndView(currGameScreen: $currGameScreen)
                                    .environmentObject(gameEngineMgr3)

                                GameEndView(currGameScreen: $currGameScreen)
                                    .environmentObject(gameEngineMgr4)
                            }
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

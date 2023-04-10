//
//  GameModeSelectView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import SwiftUI

struct GameModeSelectView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @Binding var currGameScreen: Constants.CurrGameScreens
    
    var body: some View {
        ZStack {

            BackgroundView()

            VStack {
                Spacer()
                Text("Choose your game mode:")
                    .modifier(MenuButtonText(fontSize: 50))
                Spacer().frame(height: 100)

                VStack {

                    if $mainGameMgr.playersMode.wrappedValue == .singleplayer {
                        HStack {
                            drawGameModeOption(gameMode: .SURVIVAL, playerMode: .singleplayer,
                                               name: Constants.GameModeTypes.SURVIVAL.rawValue.uppercased(),
                                               fontSize: 30.0, red: 1, green: 0.341, blue: 0.341)

                            drawGameModeOption(gameMode: .SANDBOX, playerMode: .singleplayer,
                                               name: Constants.GameModeTypes.SANDBOX.rawValue.uppercased(),
                                               fontSize: 30.0, red: 0.322, green: 0.443, blue: 1)
                        }

                        HStack {
                            drawGameModeOption(gameMode: .RACECLOCK, playerMode: .singleplayer,
                                               name: Constants.GameModeTypes.RACECLOCK.rawValue.uppercased(),
                                               fontSize: 30.0, red: 0.322, green: 1, blue: 0.322)
                        }
                    } else if $mainGameMgr.playersMode.wrappedValue == .multiplayer {
                        HStack {
                            drawGameModeOption(gameMode: .SURVIVAL, playerMode: .multiplayer,
                                               name: Constants.GameModeTypes.SURVIVAL.rawValue.uppercased(),
                                               fontSize: 30.0, red: 1, green: 0.341, blue: 0.341)

                            drawGameModeOption(gameMode: .SANDBOX, playerMode: .multiplayer,
                                               name: Constants.GameModeTypes.SANDBOX.rawValue.uppercased(),
                                               fontSize: 30.0, red: 0.322, green: 0.443, blue: 1)
                        }

                        HStack {
                            drawGameModeOption(gameMode: .RACECLOCK, playerMode: .multiplayer,
                                               name: Constants.GameModeTypes.RACECLOCK.rawValue.uppercased(),
                                               fontSize: 30.0, red: 0.322, green: 1, blue: 0.322)
                        }
                    }
                }

                Button {
                    withAnimation {
                        currGameScreen = .playerOptionSelection
                        mainGameMgr.stopGames()
                    }
                } label: {
                    Text("Back")
                        .modifier(CustomButton(fontSize: 25))
                }

//                GameplayGoBackMenuView(currGameScreen: $currGameScreen)
//                .padding(.top, 35.0)

                Spacer()
            }
        }
        .ignoresSafeArea(.all)

    }

    private func drawGameModeOption(gameMode: Constants.GameModeTypes, playerMode: PlayersMode, name: String, fontSize: CGFloat, red: Double, green: Double, blue: Double) -> AnyView {
        AnyView(
            Button {
                mainGameMgr.gameMode = gameMode
                if playerMode == .singleplayer {
                    currGameScreen = .singleplayerGameplay
                } else if playerMode == .multiplayer {
                    // do something
                    currGameScreen = .multiplayerGameplay
                }
            } label: {
                Text(name)
                    .modifier(SecondaryButton(fontSize: fontSize, red: red, green: green, blue: blue))
            }
        )
    }
}

struct GameModeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeSelectView(currGameScreen: .constant(.gameModeSelection))
    }
}

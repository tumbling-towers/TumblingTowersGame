//
//  GameModeSelectView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import SwiftUI

struct GameModeSelectView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
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
                    HStack {
                        drawGameModeOption(gameMode: .SURVIVAL, name: "SURVIVAL", fontSize: 30.0, red: 1, green: 0.341, blue: 0.341)

                        drawGameModeOption(gameMode: .SANDBOX, name: "SANDBOX", fontSize: 30.0, red: 0.322, green: 0.443, blue: 1)
                    }

                    HStack {
                        drawGameModeOption(gameMode: .RACECLOCK, name: "RACE THE CLOCK", fontSize: 30.0, red: 0.322, green: 1, blue: 0.322)
                    }
                }

                Button {
                    currGameScreen = .mainMenu
                    gameEngineMgr.stopGame()
                } label: {
                    Text("Back")
                        .modifier(CustomButton(fontSize: 25))
                }
                .padding(.top, 35.0)

                Spacer()
            }
        }
        .ignoresSafeArea(.all)

    }

    private func drawGameModeOption(gameMode: Constants.GameModeTypes, name: String, fontSize: CGFloat, red: Double, green: Double, blue: Double) -> AnyView {
        AnyView(
            Button {
                gameEngineMgr.startGame(gameMode: gameMode)
                currGameScreen = .gameplay
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
            .environmentObject(GameEngineManager(levelDimensions: .infinite,
                                                 eventManager: TumblingTowersEventManager()))
    }
}

//
//  PlayersSelectView.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 7/4/23.
//

import SwiftUI

struct PlayersSelectView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {

            BackgroundView()

            VStack {
                Spacer()
                Text("How many players:")
                    .modifier(MenuButtonText(fontSize: 50))
                Spacer().frame(height: 100)
                HStack {
                    drawPlayersOption(playersMode: .singleplayer,
                                      name: "Singleplayer",
                                      fontSize: 30.0,
                                      red: 1,
                                      green: 0.341,
                                      blue: 0.341)

                    drawPlayersOption(playersMode: .multiplayer,
                                      name: "Multiplayer",
                                      fontSize: 30.0,
                                      red: 0.322,
                                      green: 0.443,
                                      blue: 1)
                }

                NormalGoBackButtonView(currGameScreen: $currGameScreen)
                .padding(.top, 35.0)

                Spacer()
            }
        }
        .ignoresSafeArea(.all)

    }

    private func drawPlayersOption(playersMode: PlayersMode,
                                   name: String,
                                   fontSize: CGFloat,
                                   red: Double,
                                   green: Double,
                                   blue: Double) -> AnyView {
        AnyView(
            Button {
                withAnimation {
                    mainGameMgr.playersMode = playersMode
                    currGameScreen = .gameModeSelection
                }
            } label: {
                Text(name)
                    .modifier(CustomButton(fontSize: fontSize))
            }
        )
    }

}

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
                Text("Select Game Mode::")
                    .font(.system(size: 30))
                    .padding(.all, 30)

                HStack {
                    drawGameModeOption(gameMode: .SURVIVAL, name: "SURVIVAL", fontSize: 30.0)

                    drawGameModeOption(gameMode: .SANDBOX, name: "SANDBOX", fontSize: 30.0)

                    // MARK: Add back later
//                    drawGameModeOption(gameMode: .RACECLOCK, name: "RACE AGAINST CLOCK", fontSize: 30.0)
                }

                Button {
                    currGameScreen = .mainMenu
                } label: {
                    Text("BACK")
                        .modifier(MenuButtonText(fontSize: 20))
                }
                .padding(.top, 35.0)

                drawInstructions()

                Spacer()
            }
        }
        .ignoresSafeArea(.all)

    }

    private func drawGameModeOption(gameMode: Constants.GameModeTypes, name: String, fontSize: CGFloat) -> AnyView {
        AnyView(
            Button {
//                gameEngineMgr.setGameMode(gameMode: gameMode)
                gameEngineMgr.startGame(gameMode: gameMode)
                currGameScreen = .gameplay
            } label: {
                Text(name)
                    .modifier(MenuButtonText(fontSize: fontSize))
            }
        )
    }

    private func drawInstructions() -> AnyView {
        AnyView(
            Text("Choose your Game Mode!")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .bold))
                .padding(.top, 100)
        )
    }
}

struct GameModeSelectView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeSelectView(currGameScreen: .constant(.gameModeSelection))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
    }
}

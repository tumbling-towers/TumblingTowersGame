//
//  GameEndView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 31/3/23.
//

import SwiftUI

struct GameEndView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        VStack {
            ZStack {
                BackgroundView()

                VStack {
                    drawGameLostText()

                    drawGameWinText()

                    Text("Timer: " + String(gameEngineMgr.timeRemaining) + "!")
                        .font(.system(size: 30))
                }
            }

            GameplayGoBackMenuView(currGameScreen: $currGameScreen)
                .padding(.bottom, 1)
        }
    }

    private func drawGameLostText() -> AnyView {
        AnyView(
            VStack {
                if gameEngineMgr.gameState == .LOSE_SURVIVAL {
                    Text("You LOST!")
                        .font(.system(size: 70))
                        .fontWeight(.heavy)
                    Text("You dropped too many blocks!.")
                        .font(.system(size: 30))
                }

                if gameEngineMgr.gameState == .LOSE_RACE {
                    Text("You LOST!")
                        .font(.system(size: 70))
                        .fontWeight(.heavy)
                    Text("You ran out of time!.")
                        .font(.system(size: 30))
                }
            }
        )
    }

    private func drawGameWinText() -> AnyView {
        AnyView(
            VStack {
                if gameEngineMgr.gameState == .WIN_SURVIVAL {
                    Text("Congratulations...")
                        .font(.system(size: 30))
                    Text("You stacked enough blocks!")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                    Text("Score: \(gameEngineMgr.score)")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                }

                if gameEngineMgr.gameState == .WIN_RACE {
                    Text("Congratulations...")
                        .font(.system(size: 30))
                    Text("You beat the clock!")
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                }

            }
        )
    }
}

struct GameEndView_Previews: PreviewProvider {
    static var gameEngineMgr: GameEngineManager = {
        let gameEngineManager = GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager())


        return gameEngineManager

    }()

    static var previews: some View {
        GameEndView(currGameScreen: .constant(.gameplay))
            .environmentObject(gameEngineMgr)
    }
}

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

                    Spacer()

                    drawGameEndText()

                    if let score = gameEngineMgr.score {
                        Text("Score: " + String(score))
                            .font(.system(size: 30))
                    }

                    if let timeLeft = gameEngineMgr.timeRemaining {
                        Text("Timer: " + String(timeLeft))
                            .font(.system(size: 30))
                    }

                    Spacer()

                    GameplayGoBackMenuView(currGameScreen: $currGameScreen)
                        .padding(.bottom, 1)
                    
                }

            }
        }
    }

    private func drawGameEndText() -> AnyView {
        AnyView(
            VStack {
                if gameEngineMgr.gameEnded {
                    Text(gameEngineMgr.gameEndMainMessage)
                        .font(.system(size: 70))
                        .fontWeight(.heavy)
                    Text(gameEngineMgr.gameEndSubMessage)
                        .font(.system(size: 30))
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
        GameEndView(currGameScreen: .constant(.singleplayerGameplay))
            .environmentObject(gameEngineMgr)
    }
}

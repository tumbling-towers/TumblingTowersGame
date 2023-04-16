//
//  GameEndView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 31/3/23.
//

import SwiftUI

struct GameEndView: View {
    @Binding var currGameScreen: Constants.CurrGameScreens
    var gameEngineMgr: GameEngineManager

    var body: some View {
        VStack {
            ZStack {
                BackgroundView()

                VStack {

                    Spacer()

                    drawGameEndText()

                    Text("Score: " + String(gameEngineMgr.score))
                        .font(.system(size: 30))

                    Text("Timer: " + gameEngineMgr.timeRemaining.secondsToTimeStr())
                        .font(.system(size: 30))

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
    static var previews: some View {
        GameEndView(currGameScreen: .constant(.singleplayerGameplay),
                    gameEngineMgr: GameEngineManager(levelDimensions: .infinite,
                                                     eventManager: TumblingTowersEventManager(),
                                                     inputType: TapInput.self,
                                                     storageManager: StorageManager(),
                                                     playersMode: .singleplayer))
    }
}

//
//  GameEndView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 31/3/23.
//

import SwiftUI

struct GameEndView: View {
    @EnvironmentObject var viewAdapter: ViewAdapter
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        VStack {
            ZStack {
                BackgroundView()

                VStack {

                    Spacer()

                    drawGameEndText()

//                    if let score = viewAdapter.score {
                        Text("Score: " + String(viewAdapter.score))
                            .font(.system(size: 30))
//                    }

//                    if let timeLeft = viewAdapter.timeRemaining {
                        Text("Timer: " + viewAdapter.timeRemaining.secondsToTimeStr())
                            .font(.system(size: 30))
//                    }s

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
                if viewAdapter.gameEnded {
                    Text(viewAdapter.gameEndMainMessage)
                        .font(.system(size: 70))
                        .fontWeight(.heavy)
                    Text(viewAdapter.gameEndSubMessage)
                        .font(.system(size: 30))
                }
            }
        )
    }
}

struct GameEndView_Previews: PreviewProvider {
    static var previews: some View {
        GameEndView(currGameScreen: .constant(.singleplayerGameplay))
            .environmentObject(ViewAdapter(levelDimensions: .infinite, gameEngineMgr: GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), inputType: TapInput.self, storageManager: StorageManager())))
    }
}

//
//  GameplayGuiView.swift
//  TumblingTowersGame
//
//  Created by Elvis on 8/4/23.
//

import SwiftUI

struct GameplayGuiView: View {
    @EnvironmentObject var mainGameMgr: MainGameManager
    @EnvironmentObject var viewAdapter: ViewAdapter
    
    @State var isPaused: Bool = false

    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {

            Button {
                viewAdapter.rotateCurrentBlock()
            } label: {
                Image("rotate")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(20)
            }
            .modifier(PowerupButton(height: 70,
                                    width: 70,
                                    position: CGPoint(x: viewAdapter.levelDimensions.width - 100,
                                                      y: viewAdapter.levelDimensions.height - 100)))

            ForEach(1..<$viewAdapter.powerups.count + 1) { i in
                if let powerup0 = $viewAdapter.powerups[i - 1],
                   let type = powerup0.wrappedValue?.type,
                   let image = ViewImageManager.powerupToImage[type] {
                    Button {
                        viewAdapter.usePowerup(at: i - 1)
                    } label: {
                        Image(image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(20)
                    }
                    .modifier(PowerupButton(height: 70,
                                             width: 70,
                                             position: CGPoint(x: 100,
                                                               y: Int(viewAdapter.levelDimensions.height) - 100 * (i))))
                }

            }

            Button {
                isPaused = true
                mainGameMgr.pauseGame()
            } label: {
                Image(ViewImageManager.pauseButton)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
            }
            .frame(width: 50, height: 50)
            .position(x: viewAdapter.levelDimensions.width - 50, y: 50)
            .sheet(isPresented: $isPaused) {
                PauseView(unpause: {
                    isPaused = false
                    mainGameMgr.unpauseGame()
                },
                          exit: {
                    mainGameMgr.stopGames()
                    mainGameMgr.resetGames()
                    mainGameMgr.removeAllviewAdapters()
                    currGameScreen = .mainMenu
                })
            }

            drawGameGui()

        }
    }

    private func drawGameGui() -> AnyView {
        AnyView(
            ZStack {
                Text("Score: " + String(viewAdapter.score))
                    .modifier(GameplayGuiText(fontSize: 20))
                    .frame(width: 200, height: 50, alignment: .leading)
                    .position(x: 130, y: 50)

                Text("Time: " + viewAdapter.timeRemaining.secondsToTimeStr())
                    .modifier(GameplayGuiText(fontSize: 20))
                    .frame(width: 200, height: 50, alignment: .leading)
                    .position(x: 130, y: 125)
            }
        )
    }
}

struct GameplayGuiView_Previews: PreviewProvider {
    static var previews: some View {
        GameplayGuiView(currGameScreen: .constant(.singleplayerGameplay))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), inputType: TapInput.self, storageManager: StorageManager()))
            .environmentObject(MainGameManager())
    }
}

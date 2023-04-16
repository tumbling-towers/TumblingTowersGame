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

    @State var isPaused = false

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

            drawPowerupButtons()

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
                    mainGameMgr.removeAllGameEngineMgrs()
                    currGameScreen = .mainMenu
                })
            }

            drawGameGui()
        }
    }

    private func getPowerUpImgFor(powerupType: Powerup.Type) -> String? {
        let type = powerupType.type
        let image = ViewImageManager.powerupToImage[type]

        return image
    }

    private func drawPowerupButtons() -> AnyView {
        let powerupCount = viewAdapter.powerups.count + 1
        return AnyView(
            ZStack {
                ForEach(1..<Int(powerupCount)) { idx in
                    if let currPowerupType = viewAdapter.powerups[idx - 1],
                       let image = getPowerUpImgFor(powerupType: currPowerupType) {
                        Button {
                            viewAdapter.usePowerup(at: idx - 1)
                        } label: {
                            Image(image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(20)
                        }
                        .modifier(PowerupButton(height: 70,
                                                 width: 70,
                                                 position: CGPoint(x: 100,
                                                                   y: Int(viewAdapter.levelDimensions.height)
                                                                        - 100 * (idx))))
                    }

                }
            }
        )
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
            .environmentObject(MainGameManager())
            .environmentObject(ViewAdapter(levelDimensions: .infinite,
                                           gameEngineMgr: GameInstanceController(
                                            levelDimensions: .infinite,
                                            eventManager: TumblingTowersEventManager(),
                                            inputType: TapInput.self,
                                            storageManager: StorageManager(),
                                            playersMode: .singleplayer)))
    }
}

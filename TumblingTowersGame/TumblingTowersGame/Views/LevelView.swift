//
//  LevelView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 18/3/23.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    @State var isPaused: Bool = false
    @Binding var currGameScreen: Constants.CurrGameScreens

    var body: some View {
        ZStack {
            BackgroundView()

            ForEach($gameEngineMgr.levelBlocks) { block in
                BlockView(block: block)
            }

            ForEach($gameEngineMgr.levelPlatforms) { platform in
                PlatformView(platform: platform)
            }

            PowerupLineView()

            Button {
                gameEngineMgr.rotateCurrentBlock()
            } label: {
                Image("rotate")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(20)
            }
            .modifier(PowerupButton(height: 70,
                                    width: 70,
                                    position: CGPoint(x: gameEngineMgr.levelDimensions.width - 100,
                                                      y: gameEngineMgr.levelDimensions.height - 100)))

            ForEach(1..<$gameEngineMgr.powerups.count + 1) { i in
                if let powerup0 = $gameEngineMgr.powerups[i - 1],
                   let type = powerup0.wrappedValue?.type,
                   let image = ViewImageManager.powerupToImage[type] {
                    Button {
                        gameEngineMgr.usePowerup(at: i - 1)
                    } label: {
                        Image(image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(20)
                    }
                    .modifier(PowerupButton(height: 70,
                                             width: 70,
                                             position: CGPoint(x: 100,
                                                               y: Int(gameEngineMgr.levelDimensions.height) - 100 * (i))))
                }

            }
            
            if let box = gameEngineMgr.referenceBox {
                Rectangle()
                    .path(in: box)
                    .fill(.blue.opacity(0.1), strokeBorder: .blue)
            }
            
            Button {
                isPaused = true
                gameEngineMgr.pause()
            } label: {
                Image(ViewImageManager.pauseButton)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
            }
            .frame(width: 50, height: 50)
            .position(x: gameEngineMgr.levelDimensions.width - 50, y: 50)
            .sheet(isPresented: $isPaused) {
                PauseView(unpause: {
                    isPaused = false
                    gameEngineMgr.unpause()
                },
                          exit: {
                    gameEngineMgr.stopGame()
                    currGameScreen = .mainMenu
                    
                })
            }
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(currGameScreen: .constant(.gameplay))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), storageManager: StorageManager()))
    }
}

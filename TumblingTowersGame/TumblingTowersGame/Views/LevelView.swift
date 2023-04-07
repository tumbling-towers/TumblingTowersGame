//
//  LevelView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 18/3/23.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
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

            if let box = gameEngineMgr.referenceBox {
                Rectangle()
                    .path(in: box)
                    .fill(.blue.opacity(0.1), strokeBorder: .blue)
            }
            
            GameplayGuiView(currGameScreen: $currGameScreen)
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(currGameScreen: .constant(.gameplay))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
    }
}

//
//  LevelView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 18/3/23.
//

import SwiftUI

struct LevelView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    
    var body: some View {
        return ZStack {
            BackgroundView()
            
            ForEach($gameEngineMgr.levelBlocks) { block in
                BlockView(block: block)
            }
            
            PlatformView()
            
            Button("ROTATE") {
                gameEngineMgr.rotateCurrentBlock()
            }
            .foregroundColor(.white)
            .background(Color.green)
            .position(x: 100, y: gameEngineMgr.levelDimensions.height - 100)
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}

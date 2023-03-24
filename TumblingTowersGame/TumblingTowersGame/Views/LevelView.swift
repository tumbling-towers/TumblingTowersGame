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
            
            if let box = gameEngineMgr.referenceBox {
                Rectangle()
                    .path(in: box)
                    .fill(.blue.opacity(0.1), strokeBorder: .blue)
            }
            
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}

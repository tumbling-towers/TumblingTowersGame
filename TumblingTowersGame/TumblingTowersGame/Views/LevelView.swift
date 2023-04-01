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
            
            PowerupLineView()
            
            Button {
                gameEngineMgr.rotateCurrentBlock()
            } label: {
                Image("rotate")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(20)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            // TODO: Potentially could make this adjustable to be on left/right of screen (in settings)
            .position(x: gameEngineMgr.levelDimensions.width - 100, y: gameEngineMgr.levelDimensions.height - 100)
            .shadow(color: .black, radius: 5, x: 1, y: 1)

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
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
    }
}

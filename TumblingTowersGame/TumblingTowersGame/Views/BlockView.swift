//
//  BlockView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import SwiftUI

struct BlockView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    @Binding var block: GameObjectBlock

    var body: some View {
        // TODO: should not coalesce
        Image(ViewImageManager.getBlockImage(block) ?? "")
            .position(block.position)
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(block: .constant(GameObjectBlock.sampleBlock))
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}

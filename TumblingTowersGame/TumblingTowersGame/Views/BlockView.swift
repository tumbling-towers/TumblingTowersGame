//
//  BlockView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import SwiftUI

struct ScaledPath: Shape {
    let cgPath: CGPath

    func path(in rect: CGRect) -> Path {
        Path(cgPath)
    }
}

struct BlockView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager
    @Binding var block: GameObjectBlock

    var body: some View {
        return ScaledPath(cgPath: block.path)
            .stroke(lineWidth: 2)
            .frame(width: block.width, height: block.height)
            .position(block.position)
    }
}

struct BlockView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView(block: .constant(GameObjectBlock.sampleBlock))
            .environmentObject(GameEngineManager(levelDimensions: .infinite))
    }
}

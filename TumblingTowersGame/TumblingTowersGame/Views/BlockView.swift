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
    static let color = Color(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1),
        opacity: 1
    )

    var body: some View {
        return PathViewShape(cgPath: block.path)
            .fill(BlockView.color, strokeBorder: .black, lineWidth: 2)
            .frame(width: block.width, height: block.height)
            .position(block.position)
    }
}

struct BlockView_Previews: PreviewProvider {
    // FIXME: this intantiating a new event manager here is wrong
    static var previews: some View {
        BlockView(block: .constant(GameObjectBlock.sampleBlock))
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager()))
    }
}

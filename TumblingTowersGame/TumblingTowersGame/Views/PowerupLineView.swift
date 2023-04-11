//
//  PowerupLineView.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 27/3/23.
//

import Foundation
import SwiftUI

struct PowerupLineView: View {
    @EnvironmentObject var gameEngineMgr: GameEngineManager

    var body: some View {
        PathViewShape(cgPath: CGPath(rect: CGRect(x: gameEngineMgr.powerUpLinePosition.x,
                                                         y: gameEngineMgr.powerUpLinePosition.y,
                                                         width: gameEngineMgr.powerupLineDimensions.width,
                                                         height: gameEngineMgr.powerupLineDimensions.height), transform: nil))
        .fill(.red, strokeBorder: .white, lineWidth: 1)

    }
}
//
struct PowerupLineView_Previews: PreviewProvider {
    static var previews: some View {
        PowerupLineView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), storageManager: StorageManager()))
    }
}

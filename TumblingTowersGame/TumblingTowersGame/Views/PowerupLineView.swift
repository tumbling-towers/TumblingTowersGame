//
//  PowerupLineView.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 27/3/23.
//

import Foundation
import SwiftUI

struct PowerupLineView: View {
    @EnvironmentObject var viewAdapter: ViewAdapter

    var body: some View {
        PathViewShape(cgPath: CGPath(rect: CGRect(x: viewAdapter.powerUpLinePosition.x,
                                                         y: viewAdapter.powerUpLinePosition.y,
                                                         width: viewAdapter.powerupLineDimensions.width,
                                                         height: viewAdapter.powerupLineDimensions.height), transform: nil))
        .fill(.red, strokeBorder: .white, lineWidth: 1)

    }
}
//
struct PowerupLineView_Previews: PreviewProvider {
    static var previews: some View {
        PowerupLineView()
            .environmentObject(GameEngineManager(levelDimensions: .infinite, eventManager: TumblingTowersEventManager(), inputType: TapInput.self, storageManager: StorageManager()))
    }
}

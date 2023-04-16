//
//  PlatformView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 17/3/23.
//

import SwiftUI

struct PlatformView: View {
    @Binding var platform: GameObjectPlatform

    var body: some View {
            Image(ViewImageManager.platformImage)
                .resizable()
                .frame(
                    width: platform.width,
                    height: platform.height, alignment: .center)
                .position(platform.position)
    }
}

struct PlatformView_Previews: PreviewProvider {
    static var previews: some View {
        PlatformView(platform: .constant(GameObjectPlatform.samplePlatform))
    }
}

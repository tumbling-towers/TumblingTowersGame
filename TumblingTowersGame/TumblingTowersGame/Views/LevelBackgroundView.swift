//
//  LevelBackgroundView.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 10/4/23.
//

import Foundation
import SwiftUI

struct LevelBackgroundView: View {
    var body: some View {
        Image(ViewImageManager.backgroundImage)
            .resizable()
    }
}

struct LevelBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

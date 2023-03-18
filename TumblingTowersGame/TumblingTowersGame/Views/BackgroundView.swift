//
//  BackgroundView.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 18/3/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image(ViewImageManager.backgroundImage)
            .resizable()
            .scaledToFill()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

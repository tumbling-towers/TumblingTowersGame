//
//  GameplayBodyText.swift
//  TumblingTowersGame
//
//  Created by Elvis on 10/4/23.
//

import SwiftUI

struct GameplayBodyText: ViewModifier {
    var fontSize = 15.0
    var padding = 0.0

    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.custom("JosefinSans-Medium", size: fontSize))
            .fixedSize(horizontal: false, vertical: true)
            .padding(.all, padding)
    }
}

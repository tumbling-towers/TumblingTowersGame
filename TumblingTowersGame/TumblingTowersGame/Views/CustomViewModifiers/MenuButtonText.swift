//
//  MenuButtonText.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import SwiftUI

struct MenuButtonText: ViewModifier {
    var fontSize: CGFloat
    var padding = 10.0

    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.system(size: fontSize, weight: .bold))
            .padding(.all, padding)
    }
}

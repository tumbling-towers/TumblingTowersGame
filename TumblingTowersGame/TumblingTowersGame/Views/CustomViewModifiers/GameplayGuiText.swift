//
//  GameplayGuiText.swift
//  TumblingTowersGame
//
//  Created by Elvis on 8/4/23.
//

import SwiftUI

struct GameplayGuiText: ViewModifier {
    var fontSize: CGFloat
    var padding = 10.0

    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundColor(.black)
                .font(.custom("JosefinSans-Medium", size: fontSize))
                .padding(.all, padding)
        }.scaledToFit()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.init(red: 0.969, green: 0.933, blue: 0.855)))
    }
}

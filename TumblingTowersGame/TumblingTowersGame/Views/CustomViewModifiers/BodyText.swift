//
//  BodyText.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import SwiftUI

struct BodyText: ViewModifier {
    var fontSize = 15.0
    var padding = 0.0

    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.system(size: fontSize, weight: .light))
            .padding(.all, padding)
    }
}

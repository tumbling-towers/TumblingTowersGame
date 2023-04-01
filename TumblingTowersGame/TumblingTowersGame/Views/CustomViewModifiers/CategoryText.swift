//
//  CategoryText.swift
//  TumblingTowersGame
//
//  Created by Elvis on 29/3/23.
//

import SwiftUI

struct CategoryText: ViewModifier {
    var fontSize = 30.0
    var padding = 0.0

    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.system(size: fontSize, weight: .black))
            .padding(.all, padding)
    }
}

//
//  SquareCustomButton.swift
//  TumblingTowersGame
//
//  Created by Elvis on 10/4/23.
//

import SwiftUI

struct SquareCustomButton: ViewModifier {
    var fontSize: CGFloat
    var padding = 10.0
    var size = 75.0

    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundColor(.black)
                .font(.custom("JosefinSans-Medium", size: fontSize))
                .padding(.all, padding)
        }.frame(width: size, height: size)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.init(red: 0.969, green: 0.933, blue: 0.855)))
    }
}

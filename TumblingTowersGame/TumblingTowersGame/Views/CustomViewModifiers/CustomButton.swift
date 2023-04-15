//
//  CustomButton.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 6/4/23.
//

import SwiftUI

struct CustomButton: ViewModifier {
    var fontSize: CGFloat
    var padding = 10.0

    func body(content: Content) -> some View {
        ZStack {
            content
                .foregroundColor(.black)
                .font(.custom("JosefinSans-Medium", size: fontSize))
                .padding(.all, padding)
        }.frame(width: 300, height: 75)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.init(red: 0.969, green: 0.933, blue: 0.855)))
    }
}

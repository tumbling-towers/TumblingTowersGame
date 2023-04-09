//
//  MenuDividerLine.swift
//  TumblingTowersGame
//
//  Created by Elvis on 10/4/23.
//

import SwiftUI

struct MenuDividerLine: ViewModifier {
    var padding = 10.0

    func body(content: Content) -> some View {
        content
            .overlay(.black)
            .frame(height: 3.0)
            .padding(.all, padding)
    }
}

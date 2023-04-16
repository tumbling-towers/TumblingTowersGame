//
//  PowerupButton.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 6/4/23.
//

import Foundation
import SwiftUI

struct PowerupButton: ViewModifier {
    var height: Double = 70
    var width: Double = 70
    var position: CGPoint

    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .frame(width: width, height: height)
            .clipShape(Circle())
            .position(x: position.x, y: position.y)
            .shadow(color: .black, radius: 5, x: 1, y: 1)
    }
}

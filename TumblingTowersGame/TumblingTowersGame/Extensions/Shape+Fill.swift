//
//  Shape+Fill.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 24/3/23.
//

import Foundation
import SwiftUI

extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill,
                                                    strokeBorder strokeStyle: Stroke,
                                                    lineWidth: Double = 1) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}

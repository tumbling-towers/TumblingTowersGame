//
//  ScaledPath.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 24/3/23.
//

import Foundation
import CoreGraphics
import SwiftUI

struct PathViewShape: Shape {
    let cgPath: CGPath

    func path(in rect: CGRect) -> Path {
        Path(cgPath)
    }
}

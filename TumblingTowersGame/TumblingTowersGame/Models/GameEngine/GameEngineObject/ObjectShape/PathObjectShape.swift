//
//  File.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import Foundation
import CoreGraphics

protocol PathObjectShape: ObjectShape {
    var path: CGPath { get }
}

//
//  CGPath+Rotate.swift
//  TumblingTowersGame
//
//  Created by Taufiq Abdul Rahman on 23/3/23.
//

import Foundation
import CoreGraphics
import UIKit

extension CGPath {
    func rotate(by angle: Double) -> CGPath {
        let path = UIBezierPath(cgPath: self)
        let rotate = CGAffineTransform(rotationAngle: angle)
        path.apply(rotate)
        return path.cgPath
    }
}

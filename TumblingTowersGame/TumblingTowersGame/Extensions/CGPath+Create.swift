//
//  CGMutablePath+Create.swift
//  Facade
//
//  Created by Quan Teng Foong on 13/3/23.
//

import Foundation
import SpriteKit

extension CGPath {
    static func create(from points: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        path.move(to: points[0])

        for i in 1..<points.count {
            path.addLine(to: points[i])
        }

        path.addLine(to: points[0])
        return path
    }
}

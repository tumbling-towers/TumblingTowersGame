//
//  CGMutablePath+Create.swift
//  Facade
//
//  Created by Quan Teng Foong on 13/3/23.
//

import Foundation
import SpriteKit

extension CGPath {
    /// Takes in an array of `CGPoint` and creates a `CGPath`.
    /// If the `centered` parameter is true, translates the `CGPath` such that the
    /// center of its bounding box is at (0, 0).
    static func create(from points: [CGPoint], centered: Bool = true) -> CGPath {
        let path = CGMutablePath()
        path.move(to: points[0])

        for i in 1..<points.count {
            path.addLine(to: points[i])
        }

        path.addLine(to: points[0])

        if centered {
            let center = CGPoint(x: path.boundingBox.width / 2 + path.boundingBox.minX,
                                 y: path.boundingBox.height / 2 + path.boundingBox.minY)
            var translation = CGAffineTransform(translationX: -center.x, y: -center.y)
            guard let newCGPath = path.copy(using: &translation) else {
                // TODO: throw error. This assert(false) will throw for now
                assert(false)
                return path
            }
            return newCGPath
        }
        return path
    }
    
    static func create(from rect: CGRect, centered: Bool = true) -> CGPath {
        let path = CGPath.create(from: [CGPoint(x: rect.minX, y: rect.minY),
                             CGPoint(x: rect.maxX, y: rect.minY),
                             CGPoint(x: rect.maxX, y: rect.maxY),
                             CGPoint(x: rect.minX, y: rect.maxY)], centered: centered)
        
        return path
    }
}

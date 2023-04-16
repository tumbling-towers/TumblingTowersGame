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
    public static func create(from points: [CGPoint], centered: Bool = true) -> CGPath {
        var path = pointsToPath(from: points)

        if centered {
            path = centerThePath(path)
        }
        
        return path
    }

    private static func pointsToPath(from points: [CGPoint]) -> CGPath {
        let path = CGMutablePath()
        path.move(to: points[0])

        for point in 1..<points.count {
            path.addLine(to: points[point])
        }

        path.addLine(to: points[0])

        return path
    }

    private static func centerThePath(_ path: CGPath) -> CGPath {
        let center = CGPoint(x: path.boundingBox.width / 2 + path.boundingBox.minX,
                             y: path.boundingBox.height / 2 + path.boundingBox.minY)
        var translation = CGAffineTransform(translationX: -center.x, y: -center.y)
        guard let newCGPath = path.copy(using: &translation) else {
            assert(false)
        }
        return newCGPath
    }

    public static func create(from rect: CGRect, centered: Bool = true) -> CGPath {
        let path = CGPath.create(from: [CGPoint(x: rect.minX, y: rect.minY),
                             CGPoint(x: rect.maxX, y: rect.minY),
                             CGPoint(x: rect.maxX, y: rect.maxY),
                             CGPoint(x: rect.minX, y: rect.maxY)], centered: centered)

        return path
    }
}

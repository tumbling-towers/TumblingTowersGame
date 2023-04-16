//
//  CGPoint+arithmeticMean.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 18/3/23.
//

import Foundation

extension CGPoint {
    public static func arithmeticMean(points: [CGPoint]) -> CGPoint {
        let xValues = points.map { $0.x }
        let yValues = points.map { $0.y }
        let averageX = CGFloat(xValues.reduce(0, +)) / CGFloat(xValues.count)
        let averageY = CGFloat(yValues.reduce(0, +)) / CGFloat(yValues.count)
        return CGPoint(x: averageX, y: averageY)
    }
}

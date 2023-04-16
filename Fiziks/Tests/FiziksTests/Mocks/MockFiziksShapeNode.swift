//
//  MockFiziksShapeNode.swift
//  TumblingTowersGameTests
//
//  Created by Quan Teng Foong on 2/4/23.
//

import Foundation
import CoreGraphics
@testable import Fiziks

class MockFiziksShapeNode: FiziksShapeNode {

    static let points: [CGPoint] = [CGPoint(x: 0, y: 0),
                                    CGPoint(x: 10, y: 0),
                                    CGPoint(x: 10, y: 10),
                                    CGPoint(x: 30, y: 10),
                                    CGPoint(x: 30, y: 20),
                                    CGPoint(x: 0, y: 20)]

    let mockPath = CGPath.create(from: MockFiziksShapeNode.points)

    init() {
        super.init(path: mockPath)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

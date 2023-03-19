//
//  FiziksContactTests.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import XCTest

final class FiziksSceneTests: XCTestCase {
    var delegate: MockFiziksSceneUpdateDelegate?
    
    override func setUp() {
        delegate = MockFiziksSceneUpdateDelegate()
    }
    
    func test_didFinishUpdate() {
        let fiziksScene = FiziksScene(size: .zero, boundingRect: .zero)
        fiziksScene.fiziksSceneUpdateDelegate = delegate
        
        fiziksScene.didFinishUpdate()
        
        XCTAssertTrue(delegate?.updatedFiziksScene ?? false)
    }
}

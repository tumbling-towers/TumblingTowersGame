//
//  GameEngineObject.swift
//  Facade
//
//  Created by Taufiq Abdul Rahman on 8/3/23.
//

import Foundation

protocol GameEngineObject {
    var fiziksBody: FiziksBody { get }

    static var categoryBitmask: BitMask { get }

    static var collisionBitmask: BitMask { get }

    static var contactTestBitmask: BitMask { get }
}

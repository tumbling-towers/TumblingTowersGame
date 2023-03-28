//
//  MockFiziksContactDelegate.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 19/3/23.
//

import Foundation

class MockFiziksContactDelegate: FiziksContactDelegate {
    var begin = false
    var end = false

    func didBegin(_ contact: FiziksContact) {
        begin = true
    }

    func didEnd(_ contact: FiziksContact) {
        end = true
    }

}

//
//  MockFiziksContactDelegate.swift
//  TumblingTowersGameTests
//
//  Created by Quan Teng Foong on 2/4/23.
//

import Foundation
@testable import Fiziks

class MockFiziksContactDelegate: FiziksContactDelegate {
    func didBegin(_ contact: FiziksContact) {
        print("contact began")
        return
    }

    func didEnd(_ contact: FiziksContact) {
        print("contact ended")
        return
    }
}

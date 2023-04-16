//
//  MockEventManager.swift
//  TumblingTowersGameTests
//
//  Created by Taufiq Abdul Rahman on 16/4/23.
//

import Foundation

class MockEventManager: EventManager {
    var observerClosures: [EventIdentifier: [EventClosure]] = [:]

    func postEvent(_ event: Event) {

    }

    func registerClosure<T>(for event: T.Type, closure: @escaping EventClosure) where T: Event {

    }

    func removeAllClosures() {

    }
}

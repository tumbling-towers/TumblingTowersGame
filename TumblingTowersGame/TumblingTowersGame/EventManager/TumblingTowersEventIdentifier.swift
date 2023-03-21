//
//  TumblingTowersEventIdentifier.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

struct TumblingTowersEventIdentifier: EventIdentifier {
    let id: Int
    var notificationName: NotificationName

    init<T: TumblingTowersEvent>(_ eventType: T.Type) {
        self.id = ObjectIdentifier(eventType).hashValue
        self.notificationName = NotificationName(String(self.id))
    }
}

extension TumblingTowersEventIdentifier: Hashable {
    static func == (lhs: TumblingTowersEventIdentifier, rhs: TumblingTowersEventIdentifier) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

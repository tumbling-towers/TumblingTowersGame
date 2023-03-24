//
//  EventIdentifier.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

class EventIdentifier {
    var id: Int
    var notificationName: NotificationName
    
    init(id: Int, notificationName: NotificationName) {
        self.id = id
        self.notificationName = notificationName
    }
}

extension EventIdentifier: Hashable {
    static func == (lhs: EventIdentifier, rhs: EventIdentifier) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

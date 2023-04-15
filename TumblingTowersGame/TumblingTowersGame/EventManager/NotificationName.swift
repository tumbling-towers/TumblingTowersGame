//
//  NotificationName.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

class NotificationName {
    var name: Notification.Name

    init(_ name: String) {
        self.name = Notification.Name(name)
    }
}

extension NotificationName: Hashable {
    static func == (lhs: NotificationName, rhs: NotificationName) -> Bool {
        lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

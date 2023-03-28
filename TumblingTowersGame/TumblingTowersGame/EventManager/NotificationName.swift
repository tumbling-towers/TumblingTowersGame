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

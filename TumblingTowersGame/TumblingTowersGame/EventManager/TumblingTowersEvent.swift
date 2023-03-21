//
//  TumblingTowersEvent.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

protocol TumblingTowersEvent: Event {
}

extension TumblingTowersEvent {
    static var identifier: TumblingTowersEventIdentifier { TumblingTowersEventIdentifier(Self.self) }
    var identifier: TumblingTowersEventIdentifier { Self.identifier }
    
    func toNotification() -> Notification {
        Notification(name: self.identifier.notificationName.name, object: nil, userInfo: ["event": self])
    }
}

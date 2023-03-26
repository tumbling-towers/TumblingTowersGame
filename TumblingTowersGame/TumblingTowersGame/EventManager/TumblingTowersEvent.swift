//
//  TumblingTowersEvent.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation


class TumblingTowersEvent: Event {
    static var identifier: EventIdentifier {
        TumblingTowersEventIdentifier(Self.self)
    }
    
    var identifier: EventIdentifier {
        Self.identifier
    }
    
    func toNotification() -> TumblingTowersNotification {
        TumblingTowersNotification(name: self.identifier.notificationName, object: nil, userInfo: ["event": self])
    }
}

//
//  TumblingTowersEventIdentifier.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

class TumblingTowersEventIdentifier: EventIdentifier {
    init<T: TumblingTowersEvent>(_ eventType: T.Type) {
        let id = ObjectIdentifier(eventType).hashValue
        let notificationName = NotificationName(String(id))
        
        super.init(id: id, notificationName: notificationName)
    }
}

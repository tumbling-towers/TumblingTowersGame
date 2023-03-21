//
//  TumblingTowersNotification.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation
import NotificationCenter

class TumblingTowersNotification {
    let notification: Notification
    
    init(name: NotificationName, object: Any?, userInfo: [AnyHashable: Any]?) {
        self.notification = Notification(name: name.name, object: nil, userInfo: userInfo)
    }
    
    func toNotification() -> Notification {
        return notification
    }
}

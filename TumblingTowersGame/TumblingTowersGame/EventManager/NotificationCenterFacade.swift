//
//  NotificationCenterFacade.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

class NotificationCenterFacade {
    static var shared = NotificationCenterFacade()

    func postNotification(_ notification: TumblingTowersNotification) {
        NotificationCenter.default.post(notification.toNotification())
    }

    func createObserver(observer: AnyObject, selector: Selector, notificationName: NotificationName, object: Any?) {

        let eventName = notificationName.name
        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: eventName,
                                               object: nil)
    }

    func removeObserver(observer: Any, notificationName: NotificationName, object: Any?) {
        NotificationCenter.default.removeObserver(observer, name: notificationName.name, object: object)
    }

    func removeAllObservers(notificationNames: [NotificationName]) {
        for notificationName in notificationNames {
            NotificationCenter.default.removeObserver(self, name: notificationName.name, object: nil)
        }
    }
}

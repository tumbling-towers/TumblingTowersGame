////
////  NotificationCenterFacade.swift
////  TumblingTowersGame
////
////  Created by Lee Yong Ler on 21/3/23.
////
//
//import Foundation
//
//class NotificationCenterFacade {
//    func postNotification(_ event: TumblingTowersNotification) {
//        NotificationCenter.default.post(event.toNotification())
//    }
//
//    func createObserver<T: Event>(for event: T.Type, observer: AnyObject, selector: Selector) {
//        let notificationName = T.identifier.notificationName.name
//
//        NotificationCenter.default.addObserver(observer,
//                                               selector: selector,
//                                               name: notificationName,
//                                               object: nil)
//    }
//
//    func removeObserver(observer: Any, notificationName: NotificationName, object: Any?) {
//        NotificationCenter.default.removeObserver(observer, name: notificationName.name, object: object)
//
//    }
//}

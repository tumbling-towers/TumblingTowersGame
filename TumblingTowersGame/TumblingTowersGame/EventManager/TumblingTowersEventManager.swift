//
//  TumblingTowersEventManager.swift
//  TumblingTowersGame
//
//  A facade for NotificationCenter
//  Acts as a mediator between event emitters and event subscribers
//
//  Created by Lee Yong Ler on 21/3/23.
//

import NotificationCenter

class TumblingTowersEventManager: EventManager {
    var NCfacade: NotificationCenterFacade = NotificationCenterFacade.shared
    var observerClosures: [EventIdentifier: [EventClosure]]
    
    init() {
        observerClosures = [:]
    }

    func reinit() {
        for eventIdentifier in observerClosures.keys {
            observerClosures[eventIdentifier] = nil
            
            NCfacade.removeObserver(observer: self, notificationName: eventIdentifier.notificationName, object: nil)
        }
        
        
        observerClosures = [:]
    }
    
    
    func postEvent(_ event: Event) {
        NCfacade.postNotification(event.toNotification())
    }


    func registerClosure<T: Event>(for event: T.Type, closure: @escaping EventClosure) {
        if observerClosures[T.identifier] == nil {
            createObserver(for: event, observer: self, selector: #selector(executeObserverClosures))
        }
        
        observerClosures[T.identifier, default: []].append(closure)
    }
    
    
    @objc
    private func executeObserverClosures(_ notification: Notification) {
        guard
            let event = notification.userInfo?["event"] as? Event,
            let closures = observerClosures[event.identifier]
        else {
            return
        }

        for closure in closures {
            closure(event)
        }
    }

    private func createObserver<T: Event>(for event: T.Type, observer: AnyObject, selector: Selector) {

        let notificationName = T.identifier.notificationName
        
        NCfacade.createObserver(observer: observer, selector: selector, notificationName: notificationName, object: nil)
    }

    
    

    
//    func degisterClosure<T: Event>(for event: T.Type, closure: @escaping EventClosure) {
//        observerClosures[T.identifier]?.removeAll(where: {$0 == closure})
//    }
}

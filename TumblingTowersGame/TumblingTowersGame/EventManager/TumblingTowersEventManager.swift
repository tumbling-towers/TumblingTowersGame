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
    var NCfacade = NotificationCenterFacade.shared
    var observerClosures: [EventIdentifier: [EventClosure]]

    var addedNames = Set<NotificationName>()

    init() {
        observerClosures = [:]
        addedNames = []
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

    func removeAllClosures() {
        NCfacade.removeAllObservers(notificationNames: Array(addedNames))
        observerClosures.removeAll()
    }

    @objc
    private func executeObserverClosures(_ notification: Notification) {
        guard let event = notification.userInfo?["event"] as? Event,
              let closures = observerClosures[event.identifier]
        else { return }

        for closure in closures {
            closure(event)
        }
    }

    private func createObserver<T: Event>(for event: T.Type, observer: AnyObject, selector: Selector) {
        let notificationName = T.identifier.notificationName

        addedNames.insert(notificationName)

        NCfacade.createObserver(observer: observer, selector: selector, notificationName: notificationName)
    }
}

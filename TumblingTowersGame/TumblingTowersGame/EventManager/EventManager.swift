//
//  EventManager.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 21/3/23.
//

import Foundation

protocol EventManager {
    typealias EventClosure = (Event) -> Void
    
    var observerClosures: [TumblingTowersEventIdentifier: [EventClosure]] { get set }
    
    func reinit()
    
    func postEvent(_ event: Event)
    
    func registerClosure<T: Event>(for event: T.Type, closure: @escaping EventClosure)
    func degisterClosure<T: Event>(for event: T.Type, closure: @escaping EventClosure)
}

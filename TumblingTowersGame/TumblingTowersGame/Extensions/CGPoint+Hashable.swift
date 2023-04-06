//
//  CGPoint.swift
//  Facade
//
//  Created by Quan Teng Foong on 13/3/23.
//

 import Foundation

 extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
 }

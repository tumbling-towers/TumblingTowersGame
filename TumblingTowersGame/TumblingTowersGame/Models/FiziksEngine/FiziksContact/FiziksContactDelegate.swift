//
//  FiziksContactDelegate.swift
//  Facade
//
//  Created by Quan Teng Foong on 15/3/23.
//

import Foundation

protocol FiziksContactDelegate: AnyObject {
    func didBegin(_ contact: FiziksContact)
    func didEnd(_ contact: FiziksContact)
}

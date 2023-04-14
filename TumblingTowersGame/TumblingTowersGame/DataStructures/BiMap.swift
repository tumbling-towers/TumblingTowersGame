//
//  BiMap.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 15/3/23.
//

import Foundation

// FIXME: find a place that can be simplified using this. If not, just delete.
public struct BiMap<Key: Hashable, Value: Hashable> {
    internal var keyValueDict: [Key: Value]
    internal var valueKeyDict: [Value: Key]

    public var keys: Set<Key> {
        Set(keyValueDict.keys)
    }

    public var values: Set<Value> {
        Set(valueKeyDict.keys)
    }

    public init() {
        self.keyValueDict = [:]
        self.valueKeyDict = [:]
    }

    public subscript(key key: Key) -> Value? {
        get {
            keyValueDict[key]
        }
        set(insertedValue) {
            guard let newValue = insertedValue else {
                return
            }
            if let oldValue = keyValueDict[key] {
                valueKeyDict[oldValue] = nil
            }
            keyValueDict[key] = newValue
            valueKeyDict[newValue] = key
        }
    }

    public subscript(value value: Value) -> Key? {
        get {
            valueKeyDict[value]
        }
        set(insertedKey) {
            guard let newKey = insertedKey else {
                return
            }
            if let oldKey = valueKeyDict[value] {
                keyValueDict[oldKey] = nil
            }
            valueKeyDict[value] = newKey
            keyValueDict[newKey] = value
        }
    }
}

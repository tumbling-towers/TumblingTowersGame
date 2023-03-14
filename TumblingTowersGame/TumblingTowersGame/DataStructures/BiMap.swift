//
//  BiMap.swift
//  TumblingTowersGame
//
//  Created by Quan Teng Foong on 15/3/23.
//

import Foundation

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
    
    /*
    internal init(keyValueDict keys: [Key: Value],
                  valueKeyDict values: [Value: Key]) {
        self.keyValueDict = keys
        self.valueKeyDict = values
    }
     */

    public subscript(key key: Key) -> Value? {
        get {
            return keyValueDict[key]
        }
        set(insertedValue) {
            guard let newValue = insertedValue,
                  let oldValue = keyValueDict[key] else {
                return
            }
            valueKeyDict[oldValue] = nil
            keyValueDict[key] = newValue
            valueKeyDict[newValue] = key
        }
    }
    
    public subscript(value value: Value) -> Key? {
        get {
            return valueKeyDict[value]
        }
        set(insertedKey) {
            guard let newKey = insertedKey,
                  let oldKey = valueKeyDict[value] else {
                return
            }
            keyValueDict[oldKey] = nil
            valueKeyDict[value] = newKey
            keyValueDict[newKey] = value
        }
    }
}

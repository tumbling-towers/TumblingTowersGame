//
//  AnyCodable+Any.swift
//  TumblingTowersGame
//
//  Created by Lee Yong Ler on 8/4/23.
//
//  Referenced from https://theblueprototype.medium.com/codable-protocol-with-any-type-e05f8b73c8b2

import Foundation

enum AnyCodable {
    case string(value: String)
    case int(value: Int)
    case data(value: Data)
    case double(value: Double)
    case cgfloat(value: CGFloat)
    
    func toString() -> String? {
        switch self {
        case .string(value: let value):
            return value
        case .int(value: let value):
            return "\(value)"
        case .data(value: let value):
            return String(decoding: value, as: UTF8.self)
        case .double(value: let value):
            return String(format: "%f", value)
        case .cgfloat(value: let value):
            return String(format: "%f", value)
        }
    }
    
    enum AnyCodableError:Error {
        case missingValue
    }
}

extension AnyCodable: Codable {
    
    enum CodingKeys: String, CodingKey {
        case string, int, data, double, cgfloat
    }
    
    init(with object: Any) throws {
//        print("obj = object as? Int \(object as? Int) \(object is Int)")
//        print("obj = object as? String \(object as? String) \(object is String)")
        
        if object is Int {
            self = .int(value: object as! Int)
            return
        }
        if object is Double {
            self = .double(value: object as! Double)
            return
        }
        if object is String {
            self = .string(value: object as! String)
            return
        }
        if object is CGFloat {
            self = .cgfloat(value: object as! CGFloat)
            return
        }
        
        throw AnyCodableError.missingValue
    }
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(value: int)
            return
        }

        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(value: string)
            return
        }
        if let cgfloat = try? decoder.singleValueContainer().decode(CGFloat.self) {
            self = .cgfloat(value: cgfloat)
            return
        }
        
        if let data = try? decoder.singleValueContainer().decode(Data.self) {
            self = .data(value: data)
            return
        }

        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(value: double)
            return
        }
        
        throw AnyCodableError.missingValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value):
            try container.encode(value, forKey: .string)
        case .cgfloat(let value):
            try container.encode(value, forKey: .cgfloat)
        case .int(let value):
            try container.encode(value, forKey: .int)
        case .data(let value):
            try container.encode(value, forKey: .data)
        case .double(let value):
            try container.encode(value, forKey: .double)
        }
    }
}

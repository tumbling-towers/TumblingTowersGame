//
//  BiMapTests.swift
//  TumblingTowersGameTests
//
//  Created by Quan Teng Foong on 19/3/23.
//

import XCTest
@testable import TumblingTowersGame

final class BiMapTests: XCTestCase {

    var stringToInt: BiMap<String, Int>!

    override func setUp() {
        stringToInt = BiMap()
        for (str, int) in [("1", 1), ("2", 2), ("3", 3), ("4", 4), ("5", 5)] {
            stringToInt[key: str] = int
        }
    }

    override func tearDown() {
        stringToInt = nil
    }

    func testSubscriptKey_get() {
        for int in 1...5 {
            let intFromBiMap = stringToInt[key: String(int)]
            XCTAssertEqual(intFromBiMap, int)
        }
    }

    func testSubscriptKey_set_addNew() {
        for (str, int) in [("8", 8), ("9", 9), ("0", 0)] {
            stringToInt[key: str] = int
        }
        for int in [8, 9, 0] {
            let intFromBiMap = stringToInt[key: String(int)]
            XCTAssertEqual(intFromBiMap, int)
        }
    }

    func testSubsciptKey_set_modify() {
        for (str, int) in [("1", -1), ("3", -3), ("4", -4)] {
            stringToInt[key: str] = int
        }
        for int in [1, 3, 4] {
            let intFromBiMap = stringToInt[key: String(int)]
            XCTAssertEqual(intFromBiMap, -int)
        }
    }
    func testSubscriptValue_get() {
        for int in 1...5 {
            let stringFromBiMap = stringToInt[value: int]
            XCTAssertEqual(stringFromBiMap, String(int))
        }
    }

    func testSubscriptValue_set_addNew() {
        for (str, int) in [("8", 8), ("9", 9), ("0", 0)] {
            stringToInt[value: int] = str
        }
        for int in [8, 9, 0] {
            let stringFromBiMap = stringToInt[value: int]
            XCTAssertEqual(stringFromBiMap, String(int))
        }
    }

    func testSubsciptValue_set_modify() {
        for (str, int) in [("-1", 1), ("-3", 3), ("-4", 4)] {
            stringToInt[value: int] = str
        }
        for int in [1, 3, 4] {
            let stringFromBiMap = stringToInt[value: int]
            XCTAssertEqual(stringFromBiMap, String(-int))
        }
    }

    func testKeys() {
        let expectedKeys = Set(["1", "2", "3", "4", "5"])
        let keysFromBiMap = stringToInt.keys

        XCTAssertEqual(keysFromBiMap, expectedKeys)
    }

    func testValues() {
        let expectedValues = Set<Int>([1, 2, 3, 4, 5])
        let valuesFromBiMap = stringToInt.values

        XCTAssertEqual(valuesFromBiMap, expectedValues)
    }
}

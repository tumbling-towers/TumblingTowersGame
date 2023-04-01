//
//  LinkedListTests.swift
//  GraphADTTests
//
//  Created by Taufiq Abdul Rahman on 11/1/23.
//  Copyright © 2023 NUS CS3217. All rights reserved.
//

import XCTest

final class LinkedListTests: XCTestCase {
    private func createLinkedListWithOneElement() -> LinkedList<Int> {
        var linkedList = LinkedList<Int>()
        try? linkedList.append(5)

        return linkedList
    }

    func testConstructLinkedList_shouldReturnNonNil() {
        let linkedList = LinkedList<Int>()

        XCTAssertNotNil(linkedList, "Linked list is nil.")
    }

    func testConstructLinkedList_isEmpty_equalsTrue() {
        let linkedList = LinkedList<Int>()

        XCTAssertTrue(linkedList.isEmpty, "Newly constructed linked list is not empty.")
    }

    func testConstructLinkedList_emptyLinkedListHead_equalsNil() {
        let linkedList = LinkedList<Int>()

        XCTAssertNil(linkedList.head, "Newly constructed linked list head is not nil.")
    }

    func testConstructLinkedList_emptyLinkedListTail_equalsNil() {
        let linkedList = LinkedList<Int>()

        XCTAssertNil(linkedList.tail, "Newly constructed linked list tail is not nil.")
    }

    func testAppend_oneElement_headTailNotEqualsNil() {
        let linkedList = createLinkedListWithOneElement()

        XCTAssertFalse(linkedList.isEmpty, "Linked list with one element isEmpty should not be true")
        XCTAssertEqual(linkedList.count, 1, "Linked list with one element should have count of 1.")
        XCTAssertNotNil(linkedList.head, "Linked list with one element head should not be nil.")
        XCTAssertNotNil(linkedList.tail, "Linked list with one element tail should not be nil.")

    }

    func testAppend_oneElement_headEqualsTail() {
        let linkedList = createLinkedListWithOneElement()

        XCTAssertNotNil(linkedList.head, "Linked list head is nil.")
        XCTAssertNotNil(linkedList.tail, "Linked list tail is nil.")
        XCTAssertEqual(linkedList.head, linkedList.tail, "Linked list with one element head and tail are not equal.")
        XCTAssertNil(linkedList.tail?.next, "Linked list tail.next is not nil.")
    }

    private let linkedListElements = [1, 2, 3, 4]

    func testAppend_lastElementAppended_equalsTailValue() {
        var linkedList = LinkedList<Int>()
        linkedListElements.forEach({ element in
            try? linkedList.append(element)
        })

        XCTAssertNotNil(linkedList.tail, "Non-empty linked list tail is nil.")
        XCTAssertNotNil(linkedList.head, "Non-empty linked list head is nil.")
        XCTAssertEqual(linkedList.tail?.value, linkedListElements.last, "Tail value is not equal to last element appended.")
        XCTAssertEqual(linkedList.head?.value, linkedListElements.first, "Head value is not equal to first element appended.")
    }

    private func createLinkedListWithElements() -> LinkedList<Int> {
        var linkedList = LinkedList<Int>()
        linkedListElements.forEach({ element in
            try? linkedList.append(element)
        })
        return linkedList
    }

    func testPop_linkedListWithOneElement_headTailEqualsNil() {
        var linkedList = createLinkedListWithOneElement()
        linkedList.pop()

        XCTAssertNil(linkedList.head, "Pop should make linked list empty and head should be nil.")
        XCTAssertNil(linkedList.tail, "Pop should make linked list empty and tail should be nil.")
    }

    func testPop_emptyLinkedList_countEqualsZero() {
        var linkedList = createLinkedListWithOneElement()
        linkedList.pop()

        XCTAssertEqual(linkedList.count, 0, "Empty Linked list should have count of 0.")
    }

    func testPop_returnsElementAtFront() {
        var linkedList = createLinkedListWithElements()

        let firstElement = linkedList.pop()

        XCTAssertEqual(firstElement, linkedListElements.first)
    }

    func testPush_emptyLinkedList_newElement_equalsHeadTail() {
        var linkedList = LinkedList<String>()
        let firstElement: String = "one"

        try? linkedList.push(firstElement)

        XCTAssertNotNil(linkedList.head, "Linked List head should not be nil")
        XCTAssertNotNil(linkedList.tail, "Linked List tail should not be nil")
        XCTAssertEqual(linkedList.head?.value, firstElement)
        XCTAssertEqual(linkedList.tail?.value, firstElement)
    }

    func testPush_lastElementPushed_equalsHeadValue() {
        var linkedList = LinkedList<Int>()

        linkedListElements.forEach({ element in
            try? linkedList.push(element)
        })

        XCTAssertNotNil(linkedList.head, "Head of non-empty linked list is nil.")
        XCTAssertNotNil(linkedList.tail, "Tail of non-empty linked list is nil.")
        XCTAssertEqual(linkedList.head?.value, linkedListElements.last, "Last element pushed is not at head of linked list.")
        XCTAssertEqual(linkedList.tail?.value, linkedListElements.first, "First element pushed is not at tail of linked list.")
    }
}

//
//  QueueTests.swift
//  GraphADTTests
//
//  Created by Taufiq Abdul Rahman on 11/1/23.
//  Copyright © 2023 NUS CS3217. All rights reserved.
//

import XCTest

final class QueueTests: XCTestCase {
    private func createLinkedListWithOneElement() -> LinkedList<Int> {
        var linkedList = LinkedList<Int>()
        try? linkedList.append(5)
        
        return linkedList
    }
    
    func testConstructEmptyQueue() {
        let queue = Queue<Int>()
        
        XCTAssertNotNil(queue, "Queue is nil.")
    }
    
    func testConstructNonEmptyQueue() {
        let linkedList = createLinkedListWithOneElement()
        let queue = Queue<Int>(linkedList)
        
        XCTAssertNotNil(queue, "Queue is nil.")
    }
    
    private func createQueueWithOneElement() -> Queue<Int> {
        let linkedList = createLinkedListWithOneElement()
        let queue = Queue<Int>(linkedList)
        
        return queue
    }
    
    private func createQueueWithOneElement(_ value: Int) -> Queue<Int> {
        var linkedList = LinkedList<Int>()
        try? linkedList.append(value)
        let queue = Queue<Int>(linkedList)
        
        return queue
    }
    
    func testEqual_emptyQueueCount_countEqualsZero() {
        let queue = Queue<Int>()
        
        XCTAssertEqual(queue.count, 0, "Empty queue count is not zero.")
    }
    
    func testEqual_nonEmptyQueueCount_countEqualsOne() {
        let queue = createQueueWithOneElement()
        
        XCTAssertEqual(queue.count, 1, "Queue with one element count is not one.")
    }
    
    func testTrue_emptyQueue_isEmpty_equalsTrue() {
        let queue = Queue<Int>()
        
        XCTAssertTrue(queue.isEmpty, "Empty queue isEmpty property is false.")
    }
    
    func testFalse_queueWithOneElement_isEmpty_equalsFalse() {
        let queue = createQueueWithOneElement()
        
        XCTAssertFalse(queue.isEmpty, "Queue with one element isEmpty property is true.")
    }
    
    func testTrue_enqueueOneElement_queueCountEqualsOne() {
        var queue = Queue<String>()
        
        try? queue.enqueue("element")
        
        XCTAssertEqual(queue.count, 1, "Queue count should be 1.")
    }
    
    func testEqual_dequeueElementFromQueue_equalsElement() {
        let elementToAddToQueue = 5
        var queue = createQueueWithOneElement(elementToAddToQueue)
        
        let dequeuedElement = queue.dequeue()
        
        XCTAssertEqual(elementToAddToQueue, dequeuedElement, "Element added to queue is not equal to element popped from queue")
    }
    
    func testPop_dequeueEmptyQueue_returnsNil() {
        var emptyQueue = Queue<String>()
    
        let dequeuedElement = emptyQueue.dequeue()
        
        XCTAssertNil(dequeuedElement, "Non-nil element dequeued from empty queue.")
    }
    
    let queueElements: [String] = ["one", "two", "three", "four", "five"]
    
    func constructQueueWithElements() -> Queue<String> {
        var linkedList = LinkedList<String>()
        queueElements.forEach({ element in
            try? linkedList.append(element)
        })
        let queue = Queue<String>(linkedList)
        return queue
    }
    
    func testConstruct_queueCount_isCorrect() {
        let queue = constructQueueWithElements()
        
        XCTAssertEqual(queue.count, queueElements.count, "Queue count is incorrect.")
    }
    
    func testPeek_returnsCorrectValue() {
        let queueWithElements = constructQueueWithElements()
        let emptyQueue = Queue<Int>()
        
        let peekedElement = queueWithElements.peek()
        let peekedNilElement = emptyQueue.peek()
        
        XCTAssertEqual(peekedElement, queueElements.first, "Peek on non-empty queue returns incorrect value.")
        XCTAssertNil(peekedNilElement, "Peek on empty queue should return nil.")
    }
    
    func testRemoveAll_removesAllElementsFromQueue() {
        var queueWithElements = constructQueueWithElements()
        
        queueWithElements.removeAll()
        
        XCTAssertTrue(queueWithElements.isEmpty, "isEmpty should be true on an empty queue after removeAll().")
        XCTAssertEqual(queueWithElements.count, 0, "Count should be 0 on empty queue after removeAll().")
    }
    
    func testToArray_returnsCorrectArray() {
        let queueWithElements = constructQueueWithElements()
        let emptyQueue = Queue<Int>()
        
        let arrayFromQueue = queueWithElements.toArray()
        let arrayFromEmptyQueue = emptyQueue.toArray()
        
        XCTAssertEqual(arrayFromQueue, queueElements)
        XCTAssertEqual(arrayFromEmptyQueue, [])
    }
}

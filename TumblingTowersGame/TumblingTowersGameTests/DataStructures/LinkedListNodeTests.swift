import XCTest

final class LinkedListNodeTests: XCTestCase {
    
    func testConstruct() {
        let linkedListNode = LinkedListNode(value: 5)
        
        XCTAssertEqual(linkedListNode.value, 5, "LinkedListNode value is not correct")
    }
    
    func testEqual_nodeWithNoNext_nextIsNil() {
        let linkedListNode = LinkedListNode(value: 5)
        
        XCTAssertNil(linkedListNode.next, "LinkedListNode next is not correct")
    }
    
    func testEqual_nodeAssignedAsNext_isEqual() {
        let secondLinkedListNode = LinkedListNode(value: 5)
        let firstLinkedListNode = LinkedListNode(value: 4, next: secondLinkedListNode)
        
        XCTAssertEqual(firstLinkedListNode.next, secondLinkedListNode, "LinkedListNode next is not correct")
    }
    
    func testNotEqual_nodesWithSameValue_isNotEqual() {
        let firstLinkedListNode = LinkedListNode(value: 5)
        let secondLinkedListNode = LinkedListNode(value: 5)
        
        XCTAssertNotEqual(firstLinkedListNode, secondLinkedListNode, "LinkedListNode equality is not correct")
    }
}

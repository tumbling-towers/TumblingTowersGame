/**
 `LinkedListNode` represents an element in a LinkedList. `LinkedListNode` is a generic type with a type parameter `T`
 that is the type of the node's label. For example, `LinkedListNode<String>` is the type of linked list nodes with a
 `String` label and `LinkedListNode<Int>` is the type of linked list nodes with a `Int` Label.
 
 Each `LinkedListNode` stores the value of the node as well as the next `LinkedListNode`. In the case that there is no next `LinkedListNode`, the default value is assigned to be `nil`.
 
 Since we want to define equality of two `LinkedListNode<T>` as being the same object in memory,
 the `LinkedListNode<T>` needs to conform to the `Equatable` protocol.

 - Authors: Taufiq Bin Abdul Rahman
 Reference: https://medium.com/geekculture/linked-lists-in-swift-5-69ba9748f4b6
 */
class LinkedListNode<T>: Equatable {

    /// Checks that two objects are referencing the same object in memory.
    static func == (lhs: LinkedListNode<T>, rhs: LinkedListNode<T>) -> Bool {
        lhs === rhs
    }

    var value: T
    var next: LinkedListNode<T>?

    /// Creates a `LinkedListNode` with the given `value` and optionally the `next` node.
    init(value: T, next: LinkedListNode<T>? = nil) {
        self.value = value
        self.next = next
    }
}

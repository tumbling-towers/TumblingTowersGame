/**
 `LinkedList` represents a linear data structure consisting of `LinkedListNode` elements. It stores the reference to the first `LinkedListNode` (head)  and the last `LinkedListNode` (tail) of the `LinkedList`.
 
 - Authors: Taufiq Bin Abdul Rahman
 */
struct LinkedList<T> {
    var head: LinkedListNode<T>?
    var tail: LinkedListNode<T>?

    /// Whether the linked list is empty.
    var isEmpty: Bool {
        head == nil
    }

    var count: Int = 0

    private mutating func incrementCount() throws {
        // Need to check overflow since using `Int` for count attribute.
        let result = count.addingReportingOverflow(1)

        if result.overflow {
            throw LinkedListError.integerOverflow
        } else {
            count = result.partialValue
        }
    }

    private mutating func decrementCount() {
        count -= 1
    }

    /// Add a new element to the back of the linked list.
    /// - Throws: `LinkedListError.integerOverflow` if too many elements are added to the linked list.
    mutating func append(_ value: T) throws {
        try incrementCount()
        let newNode = LinkedListNode(value: value)

        tail?.next = newNode
        tail = newNode

        // If the linked list is empty, assign the new element to be
        // the head of the linked list.
        if head == nil {
            head = newNode
        }
    }

    /// Add a new element to the front of the linked list.
    /// - Throws: `LinkedListError.integerOverflow` if too many elements are added to the linked list.
    mutating func push(_ value: T) throws {
        try incrementCount()
        head = LinkedListNode(value: value, next: head)

        if tail == nil {
            tail = head
        }
    }

    /// Removes the element at the front of the linked list if the linked list is not empty.
    /// Otherwise, the function returns `nil`.
    mutating func pop() -> T? {
        decrementCount()
        defer {
            head = head?.next

            if isEmpty {
                tail = nil
            }
        }

        return head?.value
      }

    /// Removes all elements from the linked list by removing reference to head and tail and setting count to 0.
    mutating func removeAllElements() {
        head = nil
        tail = nil
        count = 0
    }
}

enum LinkedListError: Error {
    case integerOverflow
}

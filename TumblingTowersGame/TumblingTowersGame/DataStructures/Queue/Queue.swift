/**
 A generic `Queue` class whose elements are first-in, first-out.

 - Authors: CS3217
 */
struct Queue<T> {
    private var linkedList: LinkedList<T>

    /// Constructs an empty queue.
    init() {
        self.linkedList = LinkedList<T>()
    }

    /// Constructs a queue with a linked list.
    init(_ linkedList: LinkedList<T>) {
        self.linkedList = linkedList
    }

    /// Adds an element to the tail of the queue.
    /// - Parameter item: The element to be added to the queue
    mutating func enqueue(_ item: T) throws {
        do {
            try linkedList.append(item)
        } catch LinkedListError.integerOverflow {
            throw QueueError.queueOverflow
        } catch {
            throw QueueError.cannotEnqueueElement
        }
    }

    /// Removes an element from the head of the queue and return it.
    /// - Returns: item at the head of the queue
    mutating func dequeue() -> T? {
        linkedList.pop()
    }

    /// Returns, but does not remove, the element at the head of the queue.
    /// - Returns: item at the head of the queue
    func peek() -> T? {
        linkedList.head?.value
    }

    /// The number of elements currently in the queue.
    var count: Int {
        linkedList.count
    }

    /// Whether the queue is empty.
    var isEmpty: Bool {
        linkedList.isEmpty
    }

    /// Removes all elements in the queue.
    mutating func removeAll() {
        linkedList.removeAllElements()
    }

    /// Returns an array of the elements in their respective dequeue order, i.e.
    /// first element in the array is the first element to be dequeued.
    /// - Returns: array of elements in their respective dequeue order
    func toArray() -> [T] {
        var queueElements: [T] = []
        var linkedListNode = linkedList.head

        while linkedListNode != nil {
            if let value = linkedListNode?.value {
                queueElements.append(value)
            }
            linkedListNode = linkedListNode?.next
        }

        return queueElements
    }
}

enum QueueError: Error {
    case queueOverflow
    case cannotEnqueueElement
}

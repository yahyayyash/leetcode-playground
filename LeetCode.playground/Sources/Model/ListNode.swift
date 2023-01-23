import Foundation

public final class ListNode: Equatable {
    public var val: Int
    public var next: ListNode?
    
    /// Initializer
    public init(_ val: Int = 0, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
    
    public init(_ arr: [Int]) {
        var root: ListNode?
        self.val = arr.first ?? 0
        
        for i in stride(from: arr.count - 1, to: 0, by: -1) {
            root = insert(root, arr[i])
        }
        
        self.next = root
    }
    
    /// Insert methods
    private func insert(_ root: ListNode?, _ value: Int) -> ListNode {
        let temp: ListNode = ListNode()
        temp.val = value
        temp.next = root
        return temp
    }
    
    // MARK: - Equatable Protocol
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        var left: ListNode? = lhs
        var right: ListNode? = rhs
        
        // Only stop if both nil
        while left != nil || right != nil {
            if (left != nil && right != nil) && (left?.val == right?.val) {
                left = left?.next
                right = right?.next
            }
            // Stop when
            // 1. One of them is nil
            // 2. lhs.val != rhs.val
            else {
                return false
            }
        }
        
        return true
    }
}

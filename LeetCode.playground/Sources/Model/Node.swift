import Foundation

public final class Node {
    public var val: Int
    public var children: [Node]?
    
    /// Initializer
    public init(_ val: Int) {
        self.val = val
    }
}

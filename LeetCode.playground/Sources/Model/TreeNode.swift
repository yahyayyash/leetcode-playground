import Foundation

public final class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    
    /// Initializer
    public init() {
        self.val = 0
    }
    
    public init(_ val: Int) {
        self.val = val
    }
    
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
    
    public init(_ arr: [Int?]) {
        self.val = (arr.first ?? 0) ?? 0
        
        let temp: TreeNode? = insert(with: arr, at: .zero)
        self.left = temp?.left
        self.right = temp?.right
    }
    
    /// Private Methods
    private func insert(with arr: [Int?], at index: Int) -> TreeNode? {
        var root: TreeNode?
        if index < arr.count,
           let arrIndex: Int = arr[index]
        {
            root = TreeNode(arrIndex)
            root?.left = insert(with: arr, at: 2 * index + 1)
            root?.right = insert(with: arr, at: 2 * index + 2)
        }
        
        return root
    }
}

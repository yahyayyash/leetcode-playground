import Foundation
import XCTest

// MARK: - Day 1
// Prefix Sum

/// https://leetcode.com/problems/running-sum-of-1d-array/
/// 1480. Running Sum of 1d Array
/// Easy
func runningSum(_ nums: [Int]) -> [Int] {
    var total: Int = 0
    return nums.map {
        total += $0
        return total
    }
}

/// https://leetcode.com/problems/find-pivot-index/
/// 724. Find Pivot Index
/// Easy
func findPivotIndex(_ nums: [Int]) -> Int {
    // 1. Find the array sum
    let sum: Int = nums.reduce(0, +)
    
    // 2. Track previous sum (lhs)
    var lhs: Int = 0
    
    // 3. Iterate trough the array
    for (index, item) in nums.enumerated() {
        // 4. Check if (sum - currentItem - totalLHS) is equal to lhs
        // 5. If yes, return true
        if sum - item - lhs == lhs {
            return index
        }
        // 6. Else add current item to the lhs total
        lhs += item
    }
    
    return -1
}

// MARK: - Day 2
// String

/// https://leetcode.com/problems/isomorphic-strings/
/// 205. Isomorphic Strings
/// Easy
func isIsomorphic(_ s: String, _ t: String) -> Bool {
    /// Other way is to map the string to Array first
    /// So we don't need the strng subscrpt extension
    var lhsDict: [Character: Int] = [:]
    var rhsDict: [Character: Int] = [:]
    
    // 1. Traverse the string
    for (index, char) in s.enumerated() {
        // 2. Check if dictionary value on the lhs, is equal to dictionary value on the rhs
        // 3. If not return false
        if lhsDict[char] != rhsDict[t[index]] { return false }
        
        // 4. Assign value to the dictionary, with character as the key for both string, and index as the value
        lhsDict[char] = index
        rhsDict[t[index]] = index
    }
    
    return true
}

/// https://leetcode.com/problems/is-subsequence/
/// 392. Is Subsequence
/// Easy
func isSubsequence(_ s: String, _ t: String) -> Bool {
    // 1. Track current index on the lhs
    var currentIndex: Int = 0
    
    // 2. Iterate trough the longer string
    for char in t {
        // 3. If the current traversed char is equal to lhs[index]
        if s[currentIndex] == char {
            // 4. Add tracked index by 1
            currentIndex += 1
        }
        
        // 5. If current index is equal to lhs.length (last char of the lhs string)
        // 6. Return true
        if currentIndex == s.count {
            return true
        }
    }
    
    return false
}

// MARK: - Day 3

// MARK: - Day 4

/// https://leetcode.com/problems/middle-of-the-linked-list/
/// 876. Middle of the Linked List
/// Easy
func middleNode(_ head: ListNode?) -> ListNode? {
    var slow: ListNode? = head
    var fast: ListNode? = head?.next
    
    while fast != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    return slow
}

/// https://leetcode.com/problems/linked-list-cycle-ii/
/// 142. Linked List Cycle II
/// Medium
func detectCycle(_ head: ListNode?) -> ListNode? {
    var slow: ListNode? = head?.next
    var fast: ListNode? = head?.next?.next
    
    // Traverse list until the fast pointer reach the end or (not a cycle)
    // slow pointer refering to the same address as the fast pointer (reach cycle)
    while fast != nil && !(slow === fast) {
        slow = slow?.next
        fast = fast?.next?.next
    }
    
    // If fast pointer reach the end
    // There's no loop in the linked list, return nil
    if fast == nil {
        return nil
    }
    
    // Distance traveled by the slow pointer = distance traveled by the fast pointer
    // 2(f + a) = f + a + b + a
    // f = b
    slow = head
    
    while !(slow === fast) {
        slow = slow?.next
        fast = fast?.next
    }
    
    return slow
}

// MARK: - Day 5

/// https://leetcode.com/problems/longest-palindrome/
/// 409. Longest Palindrome
/// Easy
func longestPalindrome(_ s: String) -> Int {
    var charSum: [Int] = Array(repeating: 0, count: 64)
    var isOddExist: Bool = false
    for char in s {
        let index: Int = Int(char.asciiValue ?? 0) - 64
        charSum[index] += 1
    }
    
    let total: Int = charSum.reduce(0) { (partialResult, num) -> Int in
        if num % 2 != 0 {
            isOddExist = true
            return partialResult + num - 1
        }
        return partialResult + num
    }
    
    return isOddExist ? total + 1 : total
}

/// https://leetcode.com/problems/non-decreasing-subsequences/
/// 491. Non-decreasing Subsequences
/// Medium
func findSubsequences(_ nums: [Int]) -> [[Int]] {
    let arrayLength: Int = nums.count
    var answer: Set<[Int]> = Set()
    var sequence: [Int] = []
    
    func backTrack(index: Int) {
        if index == arrayLength {
            if sequence.count >= 2 {
                answer.insert(sequence)
            }
            return
        }
        
        if sequence.isEmpty || (sequence.last ?? 0) <= nums[index] {
            sequence.append(nums[index])
            backTrack(index: index + 1)
            sequence.popLast()
        }
        backTrack(index: index + 1)
    }
    backTrack(index: 0)
    return Array(answer)
}

// MARK: - Day 6

/// https://leetcode.com/problems/n-ary-tree-preorder-traversal/
/// 589. N-ary Tree Preorder Traversal
/// Easy
func preorder(_ root: Node?) -> [Int] {
    var output: [Int] = []
    
    func traverseNode(_ root: Node?) {
        output.append(root?.val ?? 0)
        
        if let childs: [Node] = root?.children {
            for child in childs {
                traverseNode(child)
            }
        }
    }
    
    traverseNode(root)
    return output
}

/// https://leetcode.com/problems/binary-tree-level-order-traversal/
/// 102. Binary Tree Level Order Traversal
/// Medium
func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root: TreeNode else { return [] }
    var queue: [TreeNode] = [], answer: [[Int]] = []
    
    // Add root to queue
    queue.append(root)
    
    // Loop until queue is empty
    while !queue.isEmpty {
        let queueSize: Int = queue.count - 1
        var current: [Int] = []
        
        for i in 0...queueSize {
            // Add current queue item to the currentLevel array
            current.append(queue[i].val)
            
            // Add child queueItem to the queue if they were not empty
            if let queueItemLeft: TreeNode = queue[i].left { queue.append(queueItemLeft) }
            if let queueItemRight: TreeNode = queue[i].right { queue.append(queueItemRight) }
        }
        
        answer.append(current)
        
        // Remove from the queue
        queue.removeSubrange(0...queueSize)
    }
    
    return answer
}

// MARK: - Day 7

/// https://leetcode.com/problems/binary-search/
/// 704. Binary Search
/// Easy
/* Recursive */
func search(_ nums: [Int], _ target: Int) -> Int {
    func binary(_ nums: [Int], _ target: Int, _ startIndex: Int) -> Int {
        guard nums.count > 1
        else {
            return (nums.first ?? 0) == target ? startIndex : -1
        }
        
        let midIdx: Int = nums.count / 2
        let mid: Int = nums[midIdx]
        
        if mid == target {
            return startIndex + midIdx
        }
        else if mid > target {
            return binary(Array(nums.prefix(midIdx)), target, startIndex)
        }
        else {
            return binary(Array(nums.suffix(midIdx)), target, startIndex + midIdx + nums.count % 2)
        }
    }
    
    return binary(nums, target, 0)
}

/* Iterative */
func searchIterative(_ nums: [Int], _ target: Int) -> Int {
    var l: Int = 0
    var r: Int = nums.count - 1
    
    while l <= r {
        let mid: Int = (l + r) / 2
        if nums[mid] < target {
            l = mid + 1
        }
        else if nums[mid] > target {
            r = mid - 1
        }
        else {
            return mid
        }
    }
    
    return -1
}

/// https://leetcode.com/problems/first-bad-version/
/// 278. First Bad Version
/// Easy
func isValidBST(_ root: TreeNode?) -> Bool {
    guard let root: TreeNode = root else { return true }
    
    var stack: [TreeNode] = [root]
    var current: TreeNode = root
    var prev: TreeNode?
    
    while !stack.isEmpty {
        // In-Order traversal
        // https://en.wikipedia.org/wiki/Tree_traversal
        guard let last: TreeNode = stack.last else { return false }
        current = last
        stack.removeLast()
        
        if let right: TreeNode = current.right { stack.append(right) }
        if let left: TreeNode = current.left { stack.append(left) }
        if let prev: TreeNode = prev, current.val <= prev.val { return false }
        
        // Need to move this
        prev = current
    }
    
    return true
}

// MARK: - Day 9

/// https://leetcode.com/problems/flood-fill/
/// 733. Flood Fill
/// Easy
func floodFill(_ image: [[Int]], _ sr: Int, _ sc: Int, _ color: Int) -> [[Int]] {
    typealias Coordinate = (x: Int, y: Int)
    let width: Int = image.count
    let height: Int = image.first?.count ?? 0
    let current: Int = image[sr][sc]
    
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: height), count: width)
    var output: [[Int]] = image
    var stack: [Coordinate] = []
    
    stack.append((x: sr, y: sc))
    while !stack.isEmpty {
        let x: Int = stack.last?.x ?? 0
        let y: Int = stack.last?.y ?? 0
        stack.removeLast()
        
        // Check 4 direction
        // Left
        if x - 1 >= 0 && output[x - 1][y] == current && !visited[x - 1][y] {
            stack.append((x: x - 1, y: y))
        }
        // Bottom
        if y - 1 >= 0 && output[x][y - 1] == current && !visited[x][y - 1] {
            stack.append((x: x, y: y - 1))
        }
        // Right
        if x + 1 < width && output[x + 1][y] == current && !visited[x + 1][y] {
            stack.append((x: x + 1, y: y))
        }
        // Top
        if y + 1 < height && output[x][y + 1] == current && !visited[x][y + 1] {
            stack.append((x: x, y: y + 1))
        }
        
        output[x][y] = color
        visited[x][y] = true
    }
    
    return output
}

/// https://leetcode.com/problems/number-of-islands/
/// 200. Number of Islands
/// Medium
func numIslands(_ grid: [[Character]]) -> Int {
    var initRow: Int = grid.count
    var initCol: Int = (grid.first ?? []).count
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: initCol), count: initRow)
    
    var stack: [[Int]] = []
    var output: Int = 0
    
    /* Constant */
    let direction: [[Int]] = [
        [0,1], // Top
        [0,-1],// Bottm
        [1,0], // Right
        [-1,0] // Left
    ]
    
    for i in 0..<initRow {
        for j in 0..<initCol {
            if grid[i][j] == "1" && visited[i][j] == false {
                stack.append([i, j])
                traverseIsland()
            }
            visited[i][j] = true
        }
    }
    
    /* Helper */
    func traverseIsland() {
        while !stack.isEmpty {
            let currentRow: Int = stack.last?[0] ?? 0
            let currentCol: Int = stack.last?[1] ?? 0
            
            visited[currentRow][currentCol] = true
            stack.removeLast()
            checkCurrentNodes(row: currentRow, col: currentCol)
        }
        
        output += 1
    }
    
    func checkCurrentNodes(row: Int, col: Int) {
        for i in direction {
            let newRow: Int = row + i[1]
            let newCol: Int = col + i[0]
            if newRow < initRow && newRow >= 0 && newCol < initCol && newCol >= 0 && visited[newRow][newCol] == false {
                if grid[newRow][newCol] == "1" {
                    stack.append([newRow, newCol])
                }
            }
        }
    }
    
    return output
}

// MARK: - Test
final class LeetCodeTest: XCTestCase {
    // Day 1
    // Prefix Sum
    func testRunningSum() {
        XCTAssertEqual(runningSum([1,2,3,4]), [1,3,6,10])
        XCTAssertEqual(runningSum([3,1,2,10,1]), [3,4,6,16,17])
    }
    
    func testFindPivotIndex() {
        XCTAssertEqual(findPivotIndex([1,7,3,6,5,6]), 3)
        XCTAssertEqual(findPivotIndex([1,2,3]), -1)
        XCTAssertEqual(findPivotIndex([2,1,-1]), 0)
    }
    
    // Day 2
    // String
    func testIsIsomorphic() {
        XCTAssertTrue(isIsomorphic("egg", "add"))
        XCTAssertFalse(isIsomorphic("foo", "bar"))
        XCTAssertTrue(isIsomorphic("paper", "title"))
    }
    
    func testIsSubsequence() {
        XCTAssertTrue(isSubsequence("abc", "ahbgdc"))
        XCTAssertFalse(isSubsequence("axc", "ahbgdc"))
    }
    
    // Day 4
    // Linked List
    func testMiddleNode() {
        XCTAssertEqual(middleNode(ListNode([1,2,3,4,5])), ListNode([3,4,5]))
        XCTAssertEqual(middleNode(ListNode([1,2,3,4,5,6])), ListNode([4,5,6]))
    }
    
    // Day 5
    // Greedy
    
    // Day 6
    // Tree
    
    // Day 7
    // Binary Search
    
    // Day 8
    // Binary Search Tree
    
    // Day 9
    // Graph/DFS/BFS
    func testNumIslands() {
        XCTAssertEqual(numIslands([["1","1","1","1","0"],["1","1","0","1","0"],["1","1","0","0","0"],["0","0","0","0","0"]]), 1)
        XCTAssertEqual(numIslands([["1","1","0","0","0"],["1","1","0","0","0"],["0","0","1","0","0"],["0","0","0","1","1"]]), 3)
        XCTAssertEqual(numIslands([["1"]]), 1)
        XCTAssertEqual(numIslands([["0","1","0"],["1","0","1"],["0","1","0"]]), 4)
    }
}

LeetCodeTest.defaultTestSuite.run()

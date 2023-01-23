import Foundation
import XCTest

/// https://leetcode.com/problems/maximum-subarray/
/// 53. Maximum Subarray
/// Medium

/* O(n^2) solution */
func maxSubArray(_ nums: [Int]) -> Int {
    var ans: Int = nums.first ?? 0
    var sum: Int = ans
    var length: Int = nums.count - 1
    
    for i in 0...length {
        ans = max(ans, nums[i])
        sum = nums[i]
        if i < length {
            for j in (i + 1)...length {
                sum += nums[j]
                ans = max(ans, sum)
            }
        }
    }
    return ans
}

/* O(n) solution */
func maxSubArrayLinear(_ nums: [Int]) -> Int {
    guard nums.count > 1 else { return nums.first ?? 0 }
    var ans: Int = nums.first ?? 0
    var sum: Int = ans
    var length: Int = nums.count - 1
    
    // There's 3 state in the graph direction
    // 1. Increasing
    // 2. Decreasing
    // 3. Stay
    
    // Find the max amplitude
    for i in 1...length {
        if sum > 0 {
            sum += nums[i]
        }
        // Change direction, if the sum is negative
        else {
            // Set current number as starting point for the next sum
            sum = nums[i]
        }
        ans = max(ans, sum)
    }
    return ans
}

/// https://leetcode.com/problems/word-pattern/
/// 290. Word Pattern
/// Easy
func wordPattern(_ pattern: String, _ s: String) -> Bool {
    let wordArr: [String] = s.components(separatedBy: .whitespaces)
    var patternDict: [Character : String] = [:]
    var wordDict: [String : Character] = [:]
    
    if wordArr.count != pattern.count {
        return false
    }
    
    for (index, char) in pattern.enumerated() {
        if patternDict[char] == nil && wordDict[wordArr[index]] == nil {
            patternDict[char] = wordArr[index]
            wordDict[wordArr[index]] = char
        }
        else if patternDict[char] != wordArr[index] || wordDict[wordArr[index]] != char {
            return false
        }
    }
    return true
}

/* O(n) solution - iterative approach */
func reverseLinkedList(_ node: ListNode?) -> ListNode? {
    var current: ListNode? = node
    var prev: ListNode?
    var next: ListNode?
    
    while current != nil {
        next = current?.next
        current?.next = prev
        prev = current
        current = next
    }
    
    return prev
}

/* O(n) solution - recursive approach */
func reverseLinkedListRecursive(_ node: ListNode?) -> ListNode? {
    return nil
}

func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var head: ListNode?
    var prevNode: ListNode?
    var first: ListNode? = l1
    var second: ListNode? = l2
    var remaining: Int = 0
    
    while first != nil || second != nil || remaining > 0 {
        let total: Int = (first?.val ?? 0) + (second?.val ?? 0) + remaining
        remaining = total / 10
        let newNode: ListNode = ListNode(total % 10)
        first = first?.next
        second = second?.next
        
        prevNode?.next = newNode
        prevNode = newNode
        if head == nil {
            head = prevNode
        }
    }
    
    return head
}

func lengthOfLongestSubstring(_ s: String) -> Int {
    var charStore: [Int] = Array(repeating: -1, count: 128)
    var answer: Int = 0
    var count: Int = 0
    
    for (i, char) in s.enumerated() {
        let index: Int = Int(char.asciiValue ?? 0)
        print(char, charStore[index], i, answer, count)
        if charStore[index] == -1 {
            charStore[index] = i
            count += 1
        }
        else {
            let prevIndex: Int = charStore[index]
            answer = max(answer, count)
            count = i - prevIndex
            charStore = charStore.map { val in
                return val < prevIndex ? -1 : val
            }
            charStore[index] = i
        }
    }
    return max(answer, count)
}

func restoreIpAddresses(_ s: String) -> [String] {
    var answer: [String] = []
    
    checkIpAddress("", s, 4)
    func checkIpAddress(_ prefix: String, _ suffix: String, _ dots: Int) {
        guard dots > 0 else {
            if suffix.isEmpty { answer.append(prefix) }
            return
        }
        
        for i in 1...3 {
            let current: String = String(suffix.prefix(i))
            let input: String = prefix.isEmpty ? prefix : prefix + "."
            
            if current.count >= 1 && current.first != "0" && (Int(current) ?? 0) <= 255 || current == "0" {
                if (suffix.count - i) >= 0 {
                    checkIpAddress(input + current, String(suffix.suffix(suffix.count - i)), dots - 1)
                }
            }
        }
    }
    
    return answer
}

func partition(_ s: String) -> [[String]] {
    var output: [[String]] = []
    findPalindrom([], s)
    
    func findPalindrom(_ prev: [String], _ left: String) {
        // Exit condition
        if left.isEmpty {
            output.append(prev)
            return
        }
        
        for i in 1...left.count {
            let current: String = String(left.prefix(i))
            if current.isPalindrom {
                findPalindrom(prev + [current], String(left.suffix(left.count - i)))
            }
        }
    }
    
    return output
}


func findJudgeTwo(_ n: Int, _ trust: [[Int]]) -> Int {
    guard !trust.isEmpty else { return n > 1 ? -1 : 1 }
    var votesOut: [Int] = Array(repeating: 0, count: n)
    var votesIn: [Int] = votesOut
    var answer: Int = -1
    
    for people in trust {
        let voter: Int = people[0] - 1
        let candidate: Int = people[1] - 1
        
        votesOut[voter] += 1
        votesIn[candidate] += 1
    }
    
    for i in 0..<n {
        if votesOut[i] == 0 && votesIn[i] == n - 1 {
            if answer == -1 { answer = i + 1 }
            else { return -1 }
        }
    }
    
    return answer
}

// MARK: - Test
final class RandomTest: XCTestCase {
    func testMaxSubArray() {
        XCTAssertEqual(maxSubArray([-2,1,-3,4,-1,2,1,-5,4]), 6)
        XCTAssertEqual(maxSubArray([5,4,-1,7,8]), 23)
        XCTAssertEqual(maxSubArray([-1]), -1)
        XCTAssertEqual(maxSubArray([1]), 1)
    }
    
    func testMaxSubArrayLinear() {
        XCTAssertEqual(maxSubArrayLinear([-2,1,-3,4,-1,2,1,-5,4]), 6)
        XCTAssertEqual(maxSubArrayLinear([5,4,-1,7,8]), 23)
        XCTAssertEqual(maxSubArrayLinear([-1]), -1)
        XCTAssertEqual(maxSubArrayLinear([1]), 1)
    }
    
    func testWordPattern() {
        XCTAssertTrue(wordPattern("abba", "dog cat cat dog"))
        XCTAssertFalse(wordPattern("aaaa", "dog cat cat dog"))
        XCTAssertFalse(wordPattern("abba", "dog dog dog dog"))
        XCTAssertFalse(wordPattern("abba", "dog cat cat fish"))
    }
    
    func testLengthOfSubstring() {
        XCTAssertEqual(lengthOfLongestSubstring("bbbbb"), 1)
        XCTAssertEqual(lengthOfLongestSubstring("pwwkew"), 3)
        XCTAssertEqual(lengthOfLongestSubstring("abcabcbb"), 3)
        XCTAssertEqual(lengthOfLongestSubstring("bbtablud"), 6)
    }
}

RandomTest.defaultTestSuite.run()

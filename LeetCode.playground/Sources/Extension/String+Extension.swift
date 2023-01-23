import Foundation

public extension StringProtocol {
    // Subscript String with Int
    subscript(offset: Int) -> Character {
        return self[index(startIndex, offsetBy: offset)]
    }
    
    var isPalindrom: Bool {
        let length: Int = self.count
        let left: String = String(self.prefix(length / 2))
        let right: String = String(self.suffix(length / 2).reversed())
        return left == right
    }
}

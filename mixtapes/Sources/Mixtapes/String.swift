import Foundation

extension String {
    func leftPadded(to length: Int, with character: Character = " ") -> String {
        let length: Int = max(length, 0)
        guard count < length else {
            return "\(suffix(length))"
        }
        return "\(String(repeating: "\(character)", count: length - count))\(self)"
    }
}

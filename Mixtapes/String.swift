import Foundation

extension String {
    func leftPadded(to length: Int, with character: Character) -> String {
        if count < length {
            return "\(String(repeating: "\(character)", count: length - count))\(self)"
        } else {
            return "\(suffix(length))"
        }
    }
}

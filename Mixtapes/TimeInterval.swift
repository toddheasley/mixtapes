import Foundation

extension TimeInterval {
    
    // MARK: CustomStringConvertible
    var description: String {
        var seconds: Int = Int(self)
        let hours: Int = seconds / 3600
        let minutes: Int = (seconds % 3600) / 60
        seconds = seconds % 60
        if hours > 0 {
            return "\(hours):\("\(minutes)".leftPadded(to: 2, with: "0")):\("\(seconds)".leftPadded(to: 2, with: "0"))"
        }
        return "\(minutes):\("\(seconds)".leftPadded(to: 2, with: "0"))"
    }
}

extension String {
    fileprivate func leftPadded(to length: Int, with character: Character) -> String {
        if count < length {
            return "\(String(repeating: "\(character)", count: length - count))\(self)"
        } else {
            return "\(suffix(length))"
        }
    }
}

import Foundation

public struct Duration: Equatable, CustomStringConvertible {
    public let seconds: Int
    
    public init(seconds: Int = 0) {
        self.seconds = max(seconds, 0)
    }
    
    public init(seconds: TimeInterval) {
        self.init(seconds: Int(seconds))
    }
    
    // MARK: CustomStringConvertible
    public var description: String {
        let components: (hours: Int, minutes: Int, seconds: Int) = (seconds / 3600, (seconds % 3600) / 60, seconds % 60)
        guard components.hours > 0 else {
            return "\(components.minutes):\("\(components.seconds)".leftPadded(to: 2, with: "0"))"
        }
        return "\(components.hours):\("\(components.minutes)".leftPadded(to: 2, with: "0")):\("\(components.seconds)".leftPadded(to: 2, with: "0"))"
    }
}

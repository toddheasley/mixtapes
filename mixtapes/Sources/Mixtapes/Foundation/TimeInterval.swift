import Foundation

extension TimeInterval {
    public var timestamp: String {
        let components: (hours: Int, minutes: Int, seconds: Int) = (Int(self) / 3600, (Int(self) % 3600) / 60, Int(self) % 60)
        guard components.hours > 0 else {
            return "\(components.minutes):\("\(components.seconds)".leftPadded(to: 2, with: "0"))"
        }
        return "\(components.hours):\("\(components.minutes)".leftPadded(to: 2, with: "0")):\("\(components.seconds)".leftPadded(to: 2, with: "0"))"
    }
}

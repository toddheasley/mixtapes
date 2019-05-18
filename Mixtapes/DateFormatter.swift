import Foundation

extension DateFormatter {
    enum Format: String {
        case rfc3339 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ", rfc822 = "EEE, d MMM yyyy HH:mm:ss zzz"
    }
    
    convenience init(format: Format) {
        self.init()
        locale = Locale(identifier: "en_US_POSIX")
        timeZone = TimeZone(secondsFromGMT: 0)
        dateFormat = format.rawValue
    }
}

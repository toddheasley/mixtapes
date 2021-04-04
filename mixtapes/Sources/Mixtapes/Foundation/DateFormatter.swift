import Foundation

extension DateFormatter {
    static let rfc3339: DateFormatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    static let rfc822: DateFormatter = DateFormatter(format: "EEE, d MMM yyyy HH:mm:ss zzz")
    
    private convenience init(format: String) {
        self.init()
        locale = Locale(identifier: "en_US_POSIX")
        timeZone = TimeZone(secondsFromGMT: 0)
        dateFormat = format
    }
}

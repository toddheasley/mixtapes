import Foundation

extension UserDefaults {
    var url: URL? {
        set { set(newValue, forKey: "url") }
        get { url(forKey: "url") }
    }
}

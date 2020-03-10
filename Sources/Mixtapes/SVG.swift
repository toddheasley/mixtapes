import Foundation

class SVG: Resource {
    enum Name: String {
        case rss
        
        var path: String {
            return "\(rawValue).svg"
        }
        
        var data: Data {
            switch self {
            case .rss:
                return RSS_Data
            }
        }
    }
    
    private(set) var name: Name!
    
    init(name: Name, url: URL) {
        super.init(url: URL(fileURLWithPath: name.path, relativeTo: url), data: name.data)
        self.name = name
    }
}

private let RSS_Data: Data = """
<?xml version="1.0" encoding="UTF-8"?>
<svg width="24px" height="24px" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg">
    <path d="M7.5625,19.71875 C7.5625,21.5311153 6.09317815,23 4.28175457,23 C2.46932185,23 1,21.5311153 1,19.71875 C1,17.9063847 2.46932185,16.4375 4.28175457,16.4375 C6.09317815,16.4385102 7.5625,17.9063847 7.5625,19.71875 Z M1,6.2105 C10.2575,6.25075 17.758,13.73025 17.785125,23 L22,23 C21.97375,11.422875 12.589375,2.04025 1,2 C1,4.807 1,6.2105 1,6.2105 Z M1.03026552,9.12733006 L1.01189762,13.336915 C6.30536052,13.4142627 10.5828467,17.7239678 10.6140246,23.0117791 L14.8288595,23.0301699 C14.8078639,15.4087558 8.66083117,9.21487541 1.03026552,9.12733006 Z" fill="#B7B7B7"></path>
</svg>
""".data(using: .utf8)!

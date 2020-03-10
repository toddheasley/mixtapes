import Foundation
import ArgumentParser
import Mixtapes

extension Date: ExpressibleByArgument {
    
    // MARK: ExpressibleByArgument
    public init?(argument: String) {
        guard let date: Date = DateFormatter(format: .rfc3339).date(from: argument) else {
            return nil
        }
        self = date
    }
}

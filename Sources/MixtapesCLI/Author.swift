import Foundation
import ArgumentParser
import Mixtapes

extension Author: ExpressibleByArgument {
    
    // MARK: ExpressibleByArgument
    public init?(argument: String) {
        guard let url: URL = URL(argument: argument) else {
            return nil
        }
        self.init(url: url)
    }
}

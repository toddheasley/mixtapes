import Foundation
import Mixtapes

do {
    try Index(url: CommandLine.currentDirectoryURL).write()
    CommandLine.print(.finished)
    exit(0)
} catch {
    CommandLine.print(.failure(error))
    exit(1)
}

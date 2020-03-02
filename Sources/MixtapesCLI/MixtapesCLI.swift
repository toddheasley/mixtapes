import Foundation
import ArgumentParser
import Mixtapes

struct MixtapesCLI: ParsableCommand {
    @Option(help: "Set Podcast title.")
    var title: String?

    @Option(help: "Set content description.")
    var description: String?
    
    @Option(help: "Set homepage URL.")
    var homepage: URL?
    
    @Option(help: "Set author URL.")
    var author: Author?
    
    private func print(index: Index) {
        var info: [String] = []
        info.append("INFO:")
        info.append("  --title                 \"\(index.title)\"")
        info.append("  --description           \(index.description != nil ? "\"\(index.description!)\"" : "")")
        info.append("  --homepage              \(index.homepage.absoluteString)")
        info.append("  --author                \(index.author != nil ? index.author!.url.absoluteString : "")")
        info.append("")
        Swift.print(info.joined(separator: "\n"))
    }
    
    
    // MARK: ParsableCommand
    static var configuration = CommandConfiguration(abstract: Bundle.main.executableName)
    
    func run() throws {
        var index: Index = try Index(url: FileManager.default.currentDirectoryURL)
        index.title = title ?? index.title
        index.description = description ?? index.description
        index.homepage = homepage ?? index.homepage
        index.author = author ?? index.author
        try index.write()
        
        print(index: index)
    }
}

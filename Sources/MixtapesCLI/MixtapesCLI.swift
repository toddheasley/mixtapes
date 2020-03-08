import Foundation
import Cocoa
import ArgumentParser
import Mixtapes

struct MixtapesCLI: ParsableCommand {
    struct Add: ParsableCommand {
        @Argument(help: "Specify AAC file name.")
        var path: String
        
        @Option(name: .shortAndLong, help: "Set published date. Example: \(DateFormatter(format: .rfc3339).string(from: Date()))")
        var date: Date?
        
        // MARK: ParsableCommand
        static var configuration = CommandConfiguration(abstract: "Add mixtape to podcast.")
        
        func run() throws {
            let asset: Asset = try Asset(url: URL(fileURLWithPath: path, relativeTo: FileManager.default.currentDirectoryURL))
            try Remove.run(path: path)
            
            var index: Index = try Index(url: FileManager.default.currentDirectoryURL)
            index.items.append(Item(asset: asset, published: date))
            index.items.sort {
                $0.date.published > $1.date.published
            }
            try index.write()
            
            try Print.run()
        }
    }
    
    struct Remove: ParsableCommand {
        @Argument(help: "Specify AAC file name.")
        var path: String
        
        fileprivate static func run(path: String) throws {
            var index: Index = try Index(url: FileManager.default.currentDirectoryURL)
            index.items = index.items.filter { item in
                return item.attachment.url.lastPathComponent != path
            }
            try index.write()
        }
        
        // MARK: ParsableCommand
        static var configuration = CommandConfiguration(abstract: "Remove mixtape from podcast.")
        
        func run() throws {
            try Self.run(path: path)
            try Print.run()
        }
    }
    
    struct Set: ParsableCommand {
        @Option(help: "Set podcast title.")
        var title: String?

        @Option(help: "Set content description.")
        var description: String?
        
        @Option(help: "Set homepage URL.")
        var homepage: URL?
        
        @Option(help: "Set author URL. Example: mailto:toddheasley@me.com")
        var author: Author?
        
        // MARK: ParsableCommand
        static var configuration = CommandConfiguration(abstract: "Configure podcast properties.")
        
        func run() throws {
            var index: Index = try Index(url: FileManager.default.currentDirectoryURL)
            index.title = title ?? index.title
            index.description = description ?? index.description
            index.homepage = homepage ?? index.homepage
            index.author = author ?? index.author
            try index.write()
            
            try Print.run()
        }
    }
    
    struct Print: ParsableCommand {
        @Flag(name: .shortAndLong, help: "Include detailed description.")
        var verbose: Bool
        
        @Flag(name: .shortAndLong, help: "")
        var open: Bool
        
        fileprivate static func run(verbose: Bool = false) throws {
            let index: Index = try Index(url: FileManager.default.currentDirectoryURL)
            let dateFormatter: DateFormatter = DateFormatter(format: .rfc3339)
            print("PODCAST: \(index.title)")
            print("")
            if let description: String = index.description, !description.isEmpty {
                print("\(description)")
                print("")
            }
            print("HOMEPAGE: \(index.homepage.absoluteString)")
            print("")
            if let icon: Resource = index.icon {
                print("ICON: \(icon.url.lastPathComponent)")
                print("")
            }
            if let author: Author = index.author {
                print("AUTHOR: \(author.description)")
                print("")
            }
            print("ITEMS:")
            if !index.items.isEmpty {
                for item in index.items {
                    print("  \(dateFormatter.string(from: item.date.published))    \(item.attachment.url.lastPathComponent)")
                }
            } else {
                print("  <empty>")
            }
            print("")
            if verbose {
                let indexedURLs: [URL] = index.items.map { $0.attachment.url }
                let urls: [URL] = FileManager.default.index(filter: ".m4a").filter { url in
                    return !indexedURLs.contains(url)
                }
                if !urls.isEmpty {
                    print("UNPUBLISHED:")
                    for url in urls {
                        print("  \(url.lastPathComponent)")
                    }
                    print("")
                }
            }
        }
        
        // MARK: ParsableCommand
        static var configuration = CommandConfiguration(abstract: "Show podcast overview.")
        
        func run() throws {
            try Self.run(verbose: verbose)
            if open {
                NSWorkspace.shared.open(URL(fileURLWithPath: "index.html", relativeTo: FileManager.default.currentDirectoryURL))
            }
        }
    }
    
    // MARK: ParsableCommand
    static var configuration: CommandConfiguration = CommandConfiguration(abstract: "Publish any audio files as a podcast.",
        discussion: "Supports AAC files with the .\(Asset.pathExtension) file extension and pulls metadata for each podcast episode from ID3 tags. Audio files are required to contain values for title, artist and album name, as well as embedded artwork in JPEG format. Chapter markers are supported but optional. Feeds are published in both RSS and JSON Feed formats.",
        subcommands: [
            Add.self,
            Remove.self,
            Set.self,
            Print.self
        ],
        defaultSubcommand: Print.self
    )
}

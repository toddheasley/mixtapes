import Foundation

enum Option: String {
    case configure, write, none
    
    init(_ arguments: [String]) {
        switch arguments.count {
        case 1:
            self = .write
        case 2:
            guard arguments[1] == "init" else {
                fallthrough
            }
            self = .configure
        default:
            self = .none
        }
    }
}

let name: String = Bundle.main.executableURL!.lastPathComponent
let url: URL = Bundle.main.bundleURL

switch Option(CommandLine.arguments) {
case .configure:
    do {
        try Index.configure(url: url)
        print("\(name) ✅")
        exit(0)
    } catch {
        print("\(name) ❌ \(error)")
        exit(1)
    }
case .write:
    do {
        try (try Index(url: url)).write()
        print("\(name) ✅")
        exit(0)
    } catch {
        print("\(name) ❌ \(error)")
        exit(1)
    }
case .none:
    print("\(name) ❌")
    exit(1)
}

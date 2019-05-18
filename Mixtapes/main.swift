import Foundation

let name: String = Bundle.main.executableURL!.lastPathComponent

do {
    try Index(url: Bundle.main.bundleURL).write()
    print("\(name) ✅")
    exit(0)
} catch {
    print("\(name) ❌ \(error)")
    exit(1)
}

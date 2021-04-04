import AppKit

extension NSImage {
    static var clear: Self {
        return Self(data: Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAAXNSR0IArs4c6QAAAAtJREFUCFtjYGAAAAADAAHc7H1IAAAAAElFTkSuQmCC")!)!
    }
}

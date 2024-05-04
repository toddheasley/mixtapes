import AppKit

extension NSImage {
    static var clear: Self { Self(data: Data(base64Encoded: base64Encoded)!)! }
}

private let base64Encoded: String = """
iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAAXNSR0IArs4c6QAAAAtJREFUCFtjYGAAAAADAAHc7H1IAAAAAElFTkSuQmCC
"""

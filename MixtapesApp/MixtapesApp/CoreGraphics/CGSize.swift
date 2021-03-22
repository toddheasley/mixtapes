import CoreGraphics

extension CGSize {
    static func square(_ length: CGFloat = .defaultLength) -> Self {
        return CGSize(width: length, height: length)
    }
}

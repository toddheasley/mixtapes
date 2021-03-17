import AppKit

extension NSImage {
    func pngData(_ size: CGSize? = nil) throws -> Data {
        let size: CGSize = size ?? self.size
        guard size.width > 0.0, size.height > 0.0 else {
            throw Error("Image size not valid")
        }
        guard let bitmap: NSBitmapImageRep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(size.width), pixelsHigh: Int(size.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0) else {
            throw Error("Image conversion failed")
        }
        NSGraphicsContext.saveGraphicsState()
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmap)
        draw(in: NSRect(origin: .zero, size: size))
        NSGraphicsContext.restoreGraphicsState()
        guard let data: Data = bitmap.representation(using: .png, properties: [:]) else {
            throw Error("Image conversion failed")
        }
        return data
    }
}

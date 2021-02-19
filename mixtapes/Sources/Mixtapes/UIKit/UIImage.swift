import UIKit

extension UIImage {
    func resized(_ size: CGSize) -> UIImage? {
        guard size.width > 0.0, size.height > 0.0 else {
            return nil
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        defer {
            UIGraphicsEndImageContext()
        }
        let scale: CGFloat = max(self.size.width / size.width, self.size.height / size.height)
        var rect: CGRect = CGRect(x: 0.0, y: 0.0, width: self.size.width / scale, height: self.size.height / scale)
        rect.origin.x = (size.width - rect.size.width) / 2.0
        rect.origin.y = (size.height - rect.size.height) / 2.0
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

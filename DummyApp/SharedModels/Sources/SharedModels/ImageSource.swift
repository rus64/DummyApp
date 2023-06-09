import DeveloperToolsSupport
import Foundation

public enum ImageSource: Hashable {
    /// Load an image from a URL
    case url(URL)
    /// Load an image from a local preview content asset
    case preview(ImageResource)
}

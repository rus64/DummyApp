import DummyAPI
import Foundation
import SharedModels

/// A DTO to represent a product as returned from the server
struct ProductDTO: Decodable, Equatable {
    let id: Int
    let title: String
    let description: String
    let price: Decimal
    let discountPercentage: Decimal
    let rating: Decimal
    let stock: UInt
    let brand: String
    let category: String
    let thumbnail: URL
    let images: Array<URL>
}

extension ProductDTO {
    /// Convert DTO to domain model
    var model: Product {
        Product(
            id: self.id,
            title: self.title,
            description: self.description,
            price: self.price,
            discountPercentage: self.discountPercentage,
            rating: self.rating,
            stock: self.stock,
            brand: self.brand,
            category: self.category,
            thumbnail: .url(self.thumbnail),
            images: self.images.map { .url($0) }
        )
    }
}


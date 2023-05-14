//
//  ProductCell.swift
//  DummyApp
//
//  Created by Russell Yeo on 13/05/2023.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    
    var body: some View {
        AsyncImage(url: product.thumbnail) { phase in
            switch phase {
            case .empty:
                ZStack {
                    ProgressView()
                    Color.gray.opacity(0.5)
                }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Color.gray
                    .opacity(0.5)
            @unknown default:
                Color.gray
                    .opacity(0.5)
            }
        }
    }
}

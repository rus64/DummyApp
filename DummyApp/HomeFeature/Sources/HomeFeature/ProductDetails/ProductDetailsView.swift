import DummyAPI
import SwiftUI
import SharedModels

struct ProductDetailsView: View {
    @StateObject var viewModel: ProductDetailsViewModel
    @State var navigationTitle: String = ""
    
    init(product: Product) {
        let viewModel = ProductDetailsViewModel(product: product)
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    ImageCarousel(images: viewModel.images)
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .aspectRatio(contentMode: .fit)
                    
                    Spacer()
                }
                Spacer()
                
                Text(viewModel.productDescription)
                    .multilineTextAlignment(.leading)
                    .padding(12)
                
                AddToCartButton {
                    viewModel.didTapAddToCart()
                }
            }
            .navigationTitle(viewModel.navigationTitle)
        }
        
    }
}

#if DEBUG
import SharedModelsPreview

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: .preview_iPhoneX)
    }
}
#endif

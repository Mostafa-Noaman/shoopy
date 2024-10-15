import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shooppyy/models/add_to_cart_model.dart';
import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/services/auth_services.dart';
import 'package:shooppyy/services/cart_services.dart';
import 'package:shooppyy/services/product_details_services.dart';
import 'package:shooppyy/utilities/constants.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  final productDetailsService = ProductDetailsServicesImpl();
  final cartService = CartServicesImpl();
  final authService = AuthServicesImpl();
  String? size;

  Future<void> getProductDetails(String productId) async {
    emit(ProductDetailsLoading());
    try {
      final product = await productDetailsService.getProductDetails(productId);
      emit(ProductDetailsLoaded(product));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  Future<void> addToCart(ProductModel product) async {
    emit(AddingToCart());
    try {
      final currentUser = authService.currentUser;
      if (size == null) {
        emit(AddToCartError('Please select a size'));
      }
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        productId: product.id,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        size: size!,
      );
      await cartService.addProductToCart(currentUser!.uid, addToCartProduct);
      emit(AddedToCart());
    } catch (e) {
      emit(AddToCartError(e.toString()));
    }
  }

  void setSize(String newSize) {
    size = newSize;
    emit(SizeSelected(newSize));
  }
}

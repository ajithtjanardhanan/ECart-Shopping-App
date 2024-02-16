import 'package:ecartshoppingapp/new/cartrepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecartshoppingapp/models/product.dart';

import '../statemanage/events/product_event.dart';


class ProductBloc extends Bloc<ProductEvent, List<Product>> {
  final CartRepository cartRepository;

  ProductBloc(this.cartRepository) : super([]);

  @override
  Stream<List<Product>> mapEventToState(ProductEvent event) async* {
    if (event is AddProductToCart) {
      // Handle adding product to cart
    } else if (event is RemoveProductFromCart) {
      // Handle removing product from cart
    }
  }
}

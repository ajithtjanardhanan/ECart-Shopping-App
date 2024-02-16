import 'package:ecartshoppingapp/models/product.dart';
import 'package:ecartshoppingapp/models/repositories/product_repository.dart';
import 'package:ecartshoppingapp/statemanage/events/product_event.dart';
import 'package:ecartshoppingapp/statemanage/state/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductStarted) {
      yield* _mapProductStartedToState();
    }
    else if (event is LoadProductsEvent) {
      yield* _mapLoadProductsToState();
    } else if (event is AddProductToCart) {
      yield* _mapAddProductToCartToState(event);
    }
    else if (event is ProductFetched) {
      yield* _mapProductFetchedToState(event);
    } else if (event is ProductFetchError) {
      yield* _mapProductFetchErrorToState();
    }
    if (event is AddProductToCart) {
      // Handle adding product to cart
    } else if (event is RemoveProductFromCart) {
      // Handle removing product from cart
    }

  }



  Stream<ProductState> _mapLoadProductsToState() async* {
    yield ProductLoading();
    try {
      final products = await _productRepository.fetchProducts();
      yield ProductLoaded(products);
    } catch (e) {
      yield ProductFetchError();
    }
  }

  Stream<ProductState> _mapAddProductToCartToState(AddProductToCart event) async* {
    // Handle adding product to cart
  }

  Stream<ProductState> _mapProductStartedToState() async* {
    try {
      yield ProductLoading();
      final products = await _productRepository.fetchProducts();
      yield ProductLoaded(products);
    } catch (e) {
      yield ProductFetchError();
    }
  }

  Stream<ProductState> _mapProductFetchedToState(ProductFetched event) async* {
    try {
      final products = await _productRepository.fetchProducts();
      yield ProductLoaded(products);
    } catch (e) {
      yield ProductFetchError();
    }
  }

  Stream<ProductState> _mapProductFetchErrorToState() async* {
    yield ProductFetchError();
  }


}

class ProductFetchError extends ProductState {}
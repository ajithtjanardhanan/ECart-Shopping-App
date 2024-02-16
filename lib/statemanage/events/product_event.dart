import 'package:ecartshoppingapp/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];

}

class ProductStarted extends ProductEvent {}

class ProductFetched extends ProductEvent {
  final List<Product> products;

  ProductFetched(this.products);

  @override
  List<Object> get props => [products];
}

class ProductFetchError extends ProductEvent {
  @override
  List<Object> get props => [];
}

class AddProductToCart extends ProductEvent {
  final Product product;

  const AddProductToCart(this.product);

  @override
  List<Object> get props => [product];
}

class LoadProductsEvent extends ProductEvent {}



class RemoveProductFromCart extends ProductEvent {
  final int productId;

  const RemoveProductFromCart(this.productId);

  @override
  List<Object> get props => [productId];
}
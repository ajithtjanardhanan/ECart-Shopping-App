import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final String name;
  final String image;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object> get props => [id, name, image, price, quantity];
}
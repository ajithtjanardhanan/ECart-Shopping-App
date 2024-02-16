class CartItem {
  final int id;
  final String name;
  final String image;
  final double? price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    this.price = 00,
    this.quantity = 1,
  });
}
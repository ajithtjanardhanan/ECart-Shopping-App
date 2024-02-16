import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  late int productId;

  @HiveField(1)
  late String productName;

  @HiveField(2)
  late double price;

  @HiveField(3)
  late int quantity;

  CartItem({required this.productId, required this.productName, required this.price, required this.quantity});
}

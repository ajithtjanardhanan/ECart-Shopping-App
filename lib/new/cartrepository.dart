import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../models/cartitem1.dart';


class CartRepository {
  late Box<CartItem> _cartBox;

  Future<void> init() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    // Hive.registerAdapter(CartItemAdapter()); // Register the adapter
    _cartBox = await Hive.openBox<CartItem>('cart');
  }

  List<CartItem> getCartItems() {
    return _cartBox.values.toList();
  }

  void addToCart(CartItem item) {
    _cartBox.put(item.productId, item);
  }

  void removeFromCart(int productId) {
    _cartBox.delete(productId);
  }

  void clearCart() {
    _cartBox.clear();
  }

  double getNetAmount() {
    double netAmount = 0.0;
    _cartBox.values.forEach((item) {
      netAmount += (item.price * item.quantity);
    });
    return netAmount;
  }
}

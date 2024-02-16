import 'dart:io';

import 'package:ecartshoppingapp/models/CartItem.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ecartshoppingapp/models/product.dart';


abstract class CartRepository {
  Future<void> init();
  Future<void> addItem(CartItem item);
  Future<void> removeItem(int id);
  Future<void> updateItemQuantity(int id, int quantity);
  Future<List<CartItem>> getItems();
}

class HiveCartRepository implements CartRepository {
  Box? _box;

  @override
  Future<void> init() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
    _box = await Hive.openBox('cart');
  }

  @override
  Future<void> addItem(CartItem item) async {
    final existingItem = _box?.get(item.id);
    if (existingItem != null) {
      await updateItemQuantity(item.id, existingItem.quantity + item.quantity);
    } else {
      await _box?.add(item);
    }
  }

  @override
  Future<void> removeItem(int id) async {
    await _box?.delete(id);
  }

  @override
  Future<void> updateItemQuantity(int id, int quantity) async {
    final existingItem = _box?.get(id);
    if (existingItem != null) {
      existingItem.quantity = quantity;
      await _box?.put(id, existingItem);
    }
  }

  @override
  Future<List<CartItem>> getItems() async {
    final items = _box?.values.toList();
    if (items != null) {
      return items.cast<CartItem>();
    } else {
      return [];
    }
  }
}
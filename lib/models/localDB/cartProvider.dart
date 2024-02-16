import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'cart_item.dart';

class CartProvider with ChangeNotifier {
  late Database _database;

  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  int get totalItems => _cartItems.fold(0, (total, current) => total + current.quantity);

  double get totalAmount =>
      _cartItems.fold(0, (total, current) => total + current.price! * current.quantity);

  Future<void> addToCart(CartItem item) async {
    final exists = _cartItems.any((cartItem) => cartItem.id == item.id);

    if (exists) {
      final index = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
      _cartItems[index] = CartItem(
        id: item.id,
        name: item.name,
        image: item.image,
        price: item.price,
        quantity: _cartItems[index].quantity + item.quantity,
      );
    } else {
      _cartItems.add(item);
    }

    final db = await openDatabase(
      join((await getApplicationDocumentsDirectory()) as String, 'cart.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE cart (id INTEGER PRIMARY KEY, name TEXT, image TEXT, price REAL, quantity INTEGER)');
      },
      version: 1,
    );

    await db.transaction((txn) async {
      for (final cartItem in _cartItems) {
        await txn.rawInsert('INSERT INTO cart (id, name, image, price, quantity) VALUES (?, ?, ?, ?, ?)', [cartItem.id, cartItem.name, cartItem.image, cartItem.price, cartItem.quantity]);
      }
    });

    notifyListeners();
  }

  Future<void> removeFromCart(CartItem item) async {
    _cartItems.removeWhere((cartItem) => cartItem.id == item.id);

    final db = await openDatabase(
      join((await getApplicationDocumentsDirectory()) as String, 'cart.db'),
      version: 1,
    );

    await db.transaction((txn) async {
      for (final cartItem in _cartItems) {
        await txn.rawDelete('DELETE FROM cart WHERE id = ?', [cartItem.id]);
      }
    });

    notifyListeners();
  }

  Future<void> loadCartItems() async {
    final db = await openDatabase(
      join((await getApplicationDocumentsDirectory()) as String, 'cart.db'),
      version: 1,
    );

    final data = await db.query('cart');

    _cartItems = data.map((item) {
      return CartItem(
        id: item['id'] as int,
        name: item['name'] as String,
        image: item['image'] as String,
        price: item['price'] == null ? 0.0 : (item['price'] as double?)!,
        quantity: item['quantity'] as int,
      );
    }).toList();

    notifyListeners();
  }
}
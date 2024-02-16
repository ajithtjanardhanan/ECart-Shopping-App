import 'package:ecartshoppingapp/new/cartrepository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product.dart';
import '../new/CartBloc.dart';

class CartPage extends StatelessWidget {
  final CartRepository _cartRepository = CartRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Column(
        children: [
          BlocBuilder<ProductBloc, List<Product>>(
            builder: (context, state) {
              final cartItems = _cartRepository.getCartItems();
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(item.productName),
                    subtitle: Text('Price: \$${item.price} Quantity: ${item.quantity}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _cartRepository.removeFromCart(item.productId);
                        // Add logic to update the ProductBloc state when an item is removed from the cart
                      },
                    ),
                  );
                },
              );
            },
          ),
          Text('Net Amount: \$${_cartRepository.getNetAmount()}'),
        ],
      ),
    );
  }
}



import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecartshoppingapp/models/product.dart';
import 'package:ecartshoppingapp/statemanage/bloc/product_bloc.dart';
import 'package:ecartshoppingapp/statemanage/events/product_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductDetailsScreen extends StatelessWidget {
  final Product? product;

  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Product Details')),
        body: Center(child: Text('No product found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product!.title),
        elevation: 4, // Add a shadow
        backgroundColor: Colors.amber, // Change the background color
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(// Add margin from all sides
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Add a box shadow
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Image.network(
                  product!.image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                alignment: Alignment.centerLeft,// Add margin
                child: Text(
                  product!.title,
                  textAlign: TextAlign.left, // Align text to the left
                  style: TextStyle(
                    fontSize: 16.0, // Set text size
                    fontWeight: FontWeight.bold, // Make text bold
                  ),
                ),
              ),Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 15.0), // Add margin
                    child: Text(
                      '\$${product!.price}',
                      textAlign: TextAlign.left, // Align text to the left
                      style: TextStyle(
                        fontSize: 24.0, // Set text size
                        fontWeight: FontWeight.bold, // Make text bold
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () async {
                          context.read<ProductBloc>().add(AddProductToCart(product!));
                          Navigator.pushNamed(context, '/cart');
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0), // Enlarge button size
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Set border radius to 0 for rectangle shape
                              side: BorderSide(color: Colors.black, width: 2.0), // Add border
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Change button color to black
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white,
                            fontSize: 16.0, // Set text size
                            fontWeight: FontWeight.bold,), // Change text color to white
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),  // Add margin
                child: Text(
                  product!.description,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
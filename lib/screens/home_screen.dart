import 'package:ecartshoppingapp/screens/Login_Page.dart';
import 'package:ecartshoppingapp/statemanage/bloc/product_bloc.dart';
import 'package:ecartshoppingapp/statemanage/events/product_event.dart';
import 'package:ecartshoppingapp/statemanage/state/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to disable the back button
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ecart Shopping'),
          elevation: 4,
          backgroundColor: Colors.amber,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout), // Your logo icon, for example, shopping cart icon
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductInitial) {
              context.read<ProductBloc>().add(LoadProductsEvent()); // Call the LoadProductsEvent method here
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(product: product,),
                        ),
                      );
                    },
                     child : Container(
                        margin: EdgeInsets.all(8.0), // Add margin from all sides
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
                        child: GridTile(
                          child: Image.network(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                          footer: GridTileBar(
                            backgroundColor: Colors.black54,
                            title: Text(
                              product.title,
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              '\$${product.price}',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                  );
                },
              );
            } else if (state is ProductError) {
              return Center(
                // child: Text(state.message),
              );
            } else {
              return Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
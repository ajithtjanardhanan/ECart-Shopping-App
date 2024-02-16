import 'package:ecartshoppingapp/screens/Login_Page.dart';
import 'package:ecartshoppingapp/screens/SignUp.dart';
import 'package:ecartshoppingapp/models/repositories/product_repository.dart';
import 'package:ecartshoppingapp/new/cartrepository.dart';
import 'package:ecartshoppingapp/screens/home_screen.dart';
import 'package:ecartshoppingapp/statemanage/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';






Future<void> main()  async {
  // await Hive.initFlutter();
  // await CartRepository().init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductRepository productRepository = ProductRepository();
    final ProductBloc productBloc = ProductBloc(productRepository: productRepository);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecart Shopping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => productBloc,
        child: LoginPage(),
      ),
    );
  }
}

// import 'package:ecartshoppingapp/new/productbloc.dart';
// import 'package:ecartshoppingapp/new/productspage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Bloc Shopping App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: BlocProvider(
//         create: (context) => ProductBloc(),
//         child: ProductListPage(),
//       ),
//     );
//   }
// }

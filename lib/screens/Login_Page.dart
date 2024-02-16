import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecartshoppingapp/Login/Firebase_implementation/firebase_auth_services.dart';
import 'package:ecartshoppingapp/Login/Firebase_implementation/toast.dart';
import 'package:ecartshoppingapp/Login/FormContainer.dart';
import 'package:ecartshoppingapp/screens/SignUp.dart';
import 'package:ecartshoppingapp/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecartshoppingapp/statemanage/bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecartshoppingapp/models/repositories/product_repository.dart';




class LoginPage extends StatefulWidget {

  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final ProductRepository productRepository = ProductRepository();
  // final ProductBloc productBloc = ProductBloc(productRepository: productRepository);

  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logoecart.png',
                  width: 200, // Set the width here
                ),
                Text(
                  "Ecart Shopping",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(
                  height: 10,
                ),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    _signIn();
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isSigning ? CircularProgressIndicator(
                        color: Colors.white,) : Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
        
        
        
                SizedBox(
                  height: 20,
                ),
        
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      final ProductRepository productRepository = ProductRepository();
      final ProductBloc productBloc = ProductBloc(productRepository: productRepository);
      showToast(message: "User is successfully signed in");
      _emailController.clear();
      _passwordController.clear();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => productBloc,
            child: HomeScreen(),
          ),
        ),
      );
    } else {
      _emailController.clear();
      _passwordController.clear();
      showToast(message: "some error occured");
    }
  }





}
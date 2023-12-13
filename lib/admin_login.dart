import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Alogin extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Alogin({Key? key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1280;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        // Add an AppBar with a leading back arrow button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the login screen
            Navigator.pushNamed(context, '/login');
          },
        ),
        backgroundColor: Color(0xff2148c0),// Add a title for the AppBar
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color(0xff2148c0),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              width: 300 * fem,
              padding: EdgeInsets.all(16 * fem),
              decoration: BoxDecoration(
                color: const Color(0xff2148c0),
                borderRadius: BorderRadius.circular(8 * fem),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    '../assets/design1.png',
                    width: 120 * fem,
                    height: 98 * fem,
                  ),
                  SizedBox(height: 20 * fem),
                  Text(
                    'ADMIN',
                    style: TextStyle(
                      fontSize: 48 * ffem,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  TextFormField(
                    controller: _emailController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * fem),
                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * fem),
                  ElevatedButton(
                    onPressed: () {
                      // Validate email and password fields
                      if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter both email and password.'),
                          ),
                        );
                        return;
                      }

                      // Call the authentication method
                      _signInWithEmailAndPassword(context);
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 17, 15, 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * fem),
                  Text(
                    'Forgot password?',
                    style: TextStyle(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Authentication successful, navigate to the admin dashboard.
      Navigator.pushReplacementNamed(context, '/admin_dashboard');
    } catch (e) {
      // Handle authentication errors here.
      print('Authentication failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication failed: $e'),
        ),
      );

      // Clear the password field upon wrong credentials
      _passwordController.clear();
    }
  }
}

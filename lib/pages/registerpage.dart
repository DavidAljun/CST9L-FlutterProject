import 'package:flutter/material.dart';

import 'package:admin_page/authentication/firebase_auth_services.dart';

import 'package:admin_page/pages/loginpage.dart';
import 'package:admin_page/widgets/LoadingMode.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPageWidget extends StatefulWidget {
  const RegisterPageWidget({super.key});

  @override
  _RegisterPageWidgetState createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<RegisterPageWidget> {
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  late _togglePasswordVisibility _passwordVisibility; // Mark it as late

  void _showEmailVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Verification',
              style: GoogleFonts.mPlus1(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
          content: Text('Please verify your email before proceeding.',
              style: GoogleFonts.mPlus1(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              )),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/login");
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green[400],
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'OK',
                style: GoogleFonts.mPlus1(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _passwordVisibility = _togglePasswordVisibility(); // Initialize it here
  }

  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

// Function to validate email format
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

// Function to validate password
  bool isValidPassword(String password) {
    return password.length >= 6; // Password must be at least 6 characters
  }

// Function to show error dialog
  Future<void> _showErrorDialog(
      BuildContext context, String errorMessage) async {
    // Your code for showing error dialog remains the same...
  }

// Validate and register user
  // Validate and register user
  void _registerUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String firstName = _firstNameController.text.trim();
      String lastName = _lastNameController.text.trim();
      String email = _emailController.text.trim();
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;

      // Check if passwords match
      if (password != confirmPassword) {
        _showErrorDialog(context, 'Passwords do not match.');
        return;
      }

      // Validate email format
      if (!isValidEmail(email)) {
        _showErrorDialog(context, 'Invalid email format.');
        return;
      }

      // Validate password
      if (!isValidPassword(password)) {
        _showErrorDialog(
            context, 'Password must be at least 6 characters long.');
        return;
      }

      try {
        setState(() {
          isLoading = true;
        });

        // Register user with custom FirebaseAuthServices
        User? user = await _auth.signUpWithEmailAndPassword(email, password);

        if (user != null) {
          _showEmailVerificationDialog(context);
          await user.sendEmailVerification();

          // Save user-related data to Firestore
          addUserDataToFirestore(firstName, lastName, email);

          print("User is successfully created");

          // Simulate some loading time before navigating to the login page
          await Future.delayed(const Duration(seconds: 2));

          setState(() {
            isLoading = false;
          });
        } else {
          // User is null, user creation failed
          print("Error: User creation failed");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User creation failed. Please try again.'),
            ),
          );
          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        // Handle specific FirebaseAuthException errors
        print("FirebaseAuth Error Code: ${e.code}");
        print("FirebaseAuth Error Message: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User creation failed: ${e.message}'),
          ),
        );
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        // Handle generic error
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User creation failed. Please try again.'),
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> addUserDataToFirestore(
      String email, String firstName, String lastName) async {
    try {
      // Get reference to Firestore collection
      CollectionReference customerList =
          FirebaseFirestore.instance.collection('customerList');

      // Add a document with a generated ID
      await customerList.add({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'password': _passwordController.text
        // You might want to add more fields here based on your requirements
      });
    } catch (e) {
      print("Error adding user data to Firestore: $e");
      // Handle error as needed
    }
  }

  bool isLoading = false;

  void _navigateToLoginPage() async {
    setState(() {
      isLoading = true;
    });

    // Simulating some loading time before navigating to register page
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    // After the loading is done, navigate to the RegisterPageWidget
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPageWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget() // Display loading widget when isLoading is true
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/vector1.png',
                    width: 50,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              title: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'LAMZU',
                            style: GoogleFonts.mPlus1(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'LAMZU',
                            style: GoogleFonts.mPlus1(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.10),
                      child: SizedBox(
                        width: 611,
                        height: 621,
                        child: Card(
                          color: Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'REGISTER',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.mPlus1(
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    'New Customer, put down of your details below',
                                    style: GoogleFonts.mPlus1(
                                      color: Color.fromARGB(255, 184, 184, 184),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  SizedBox(height: 18),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: _firstNameController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'First Name',
                                            labelStyle: GoogleFonts.mPlus1(
                                              color: Colors.black,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your first name';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 18),
                                        TextFormField(
                                          controller: _lastNameController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Last Name',
                                            labelStyle: GoogleFonts.mPlus1(
                                              color: Colors.black,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your last name';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 18),
                                        TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Email',
                                            labelStyle: GoogleFonts.mPlus1(
                                              color: Colors.black,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter your email';
                                            } else if (!value.contains('@')) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 18),
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText:
                                              _passwordVisibility._isObscure,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Password',
                                            labelStyle: GoogleFonts.mPlus1(
                                              color: Colors.black,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisibility.toggle();
                                                });
                                              },
                                              child: Icon(
                                                _passwordVisibility.getIcon(),
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a password';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 18),
                                        TextFormField(
                                          controller:
                                              _confirmPasswordController,
                                          obscureText:
                                              _passwordVisibility._isObscure,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Confirm Password',
                                            labelStyle: GoogleFonts.mPlus1(
                                              color: Colors.black,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _passwordVisibility.toggle();
                                                });
                                              },
                                              child: Icon(
                                                _passwordVisibility.getIcon(),
                                              ),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please confirm your password';
                                            } else if (value !=
                                                _passwordController.text) {
                                              return 'Passwords do not match';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 18),
                                        ElevatedButton(
                                          onPressed: () {
                                            _registerUser(
                                                context); // Call _registerUser function on button press
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                Colors.green[400], // Text color
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            'REGISTER',
                                            style: GoogleFonts.mPlus1(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Existing Customer? ',
                                                style: GoogleFonts.mPlus1(
                                                    color: Color.fromARGB(
                                                        255, 185, 185, 185),
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                              WidgetSpan(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    _navigateToLoginPage(); // Navigate to RegisterPageWidget
                                                  },
                                                  child: Text(
                                                    'Login Here',
                                                    style: GoogleFonts.mPlus1(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF2F4),
                    border: Border.all(color: const Color(0xFFDDE1E6)),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    '© 2023 Lamzu.',
                    style: TextStyle(
                      color: Color(0xFF5F5F5F),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      letterSpacing: -0.20,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class _togglePasswordVisibility {
  bool _isObscure = true;

  IconData getIcon() {
    return _isObscure ? Icons.visibility : Icons.visibility_off;
  }

  void toggle() {
    _isObscure = !_isObscure;
  }
}

class _HeaderText extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _HeaderText({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<_HeaderText> createState() => _HeaderTextState();
}

class _HeaderTextState extends State<_HeaderText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0), // Adjust the padding as desired
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.label,
          style: GoogleFonts.mPlus1(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

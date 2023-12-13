import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin_page/widgets/LoadingMode.dart'; // Import your LoadingWidget file

// Function to handle guest login using Firebase anonymous authentication
Future<void> signInAsGuest(BuildContext context) async {
  try {
    // Set loading state to true
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LoadingWidget(); // Display LoadingWidget
      },
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();

    Navigator.pop(context); // Close the loading dialog

    if (userCredential.user != null) {
      // Successfully signed in as guest
      Navigator.pushReplacementNamed(context, "/home"); // Navigate to Home Page
    } else {
      // Guest login failed
      print("Guest login failed");
    }
  } catch (e) {
    Navigator.pop(context); // Close the loading dialog
    print("Error signing in as guest: $e");
    // Handle error if needed
  }
}

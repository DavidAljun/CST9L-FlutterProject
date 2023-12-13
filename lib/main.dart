import 'package:admin_page/widgets/LargeMouse.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Import the provider package
import 'package:admin_page/admin_customer_list.dart';
import 'package:admin_page/admin_dashboard.dart';
import 'package:admin_page/admin_login.dart';
import 'package:admin_page/admin_manage_item.dart';
import 'package:admin_page/admin_manage_order.dart';
import 'package:admin_page/firebase_options.dart';
import 'package:admin_page/pages/checkoutpage.dart';
import 'package:admin_page/pages/homepage.dart';
import 'package:admin_page/pages/loginpage.dart';
import 'package:admin_page/pages/registerpage.dart';
import 'package:admin_page/widgets/LoadingMode.dart';
import 'widgets/cart_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
       create: (context) => CartModel(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CartModel()), // Add this line
        ],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading(); // Simulate loading for a few seconds
  }

  // Simulate loading for 3 seconds and then navigate to login page
  Future<void> _simulateLoading() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Simulating a 3-second loading delay
    setState(() {
      _isLoading =
          false; // Set isLoading to false to stop showing the loading widget
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(fontFamily: "M PLUS 1p"),
      builder: (context, child) {
        return _isLoading ? LoadingWidget() : child!;
      },
      home: LoginPageWidget(),
      routes: {
        '/register': (context) => RegisterPageWidget(),
        '/home': (context) => HomePageWidget(),
        '/login': (context) => LoginPageWidget(),
        '/checkout': (context) => CheckoutPageWidget(),
        '/admin_dashboard': (context) => Adashboard(),
        '/admin_manage_order': (context) => AMorder(),
        '/admin_customer_list': (context) => Acustomer(),
        '/admin_manage_item': (context) => Amanage(),
        '/admin_login': (context) => Alogin(),
        '/LamzuAtlantis': (context) => LargeMouse(),
      },
    );
  }
}

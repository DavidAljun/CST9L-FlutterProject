import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin_page/pages/checkoutpage.dart';
import 'package:admin_page/pages/loginpage.dart';
import 'package:admin_page/pages/registerpage.dart';
import 'package:admin_page/widgets/LargeMouse.dart';
import 'package:admin_page/widgets/SmallMouse.dart';
import 'package:admin_page/widgets/MediumMouse.dart';
import 'package:admin_page/widgets/LoadingMode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_model.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/': (context) => RegisterPageWidget(),
      '/home': (context) => HomePageWidget(),
      '/login': (context) => LoginPageWidget(),
      '/checkout': (context) => CheckoutPageWidget(),
    },
  ));
}



// ignore: must_be_immutable
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();

   
}

class _HomePageWidgetState extends State<HomePageWidget> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  final PageController _pageController = PageController();
  
  bool _showProductNavBar = false;
  bool _showAdditionalText = false;

  bool isLoading = false;
  

  
  // Example async operation simulating data loading
  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    // Simulate some async task
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  // Function to sign out the user
  Future<void> _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

// Function to handle logout
  Future<void> _logout(BuildContext context) async {
    setState(() {
      isLoading = true; // Set loading state to true before signing out
    });

    try {
      await _signOut(context); // Call the sign-out function

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Logout failed: $e');
      // Handle errors
    } finally {
      setState(() {
        isLoading = false; // Set loading state to false after signing out
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // Define the animation duration
    )..repeat();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _toggleProductNavBar() {
    setState(() {
      _showProductNavBar = !_showProductNavBar;
      if (_showProductNavBar) {
        _controller.forward(); // Play the animation forward (showing the bar)
      } else {
        _controller.reverse(); // Play the animation in reverse (hiding the bar)
      }
    });
  }

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

  void _showEmailDialog(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile ? double.infinity : 800,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Left side with the picture
                  Row(
                    children: [
                      Container(
                        width: 500,
                        height: 500,
                        color: Colors
                            .black, // Replace this with your image or widget
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Title
                              Text(
                                'Up to 15% off',
                                style: GoogleFonts.mPlus1(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 24),
                              // Text label
                              Text(
                                'Get 15% off by getting a referral code through our Community Creators!',
                                style: GoogleFonts.mPlus1(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 24),
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Colors.black,
                                  ),
                                  hintText: 'Referral Code',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your sign-in logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Colors.green[400], // Text color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  'GET 15% OFF',
                                  style: GoogleFonts.mPlus1(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildClickableTextOnLamzuAtlantis() {
    return GestureDetector(
      onTap: () {
        // Navigate to another page when the text is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LargeMouse()),
        );
      },
      child: SizedBox(
        height: 25,
        child: Text(
          'LARGE MOUSE',
          style: GoogleFonts.mPlus1(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _buildClickableTextOnLamzuThorn() {
    return GestureDetector(
      onTap: () {
        // Navigate to another page when the text is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MediumMouse()),
        );
      },
      child: SizedBox(
        height: 25,
        child: Text(
          'MEDIUM MOUSE',
          style: GoogleFonts.mPlus1(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _buildClickableTextOnLamzuMaya() {
    return GestureDetector(
      onTap: () {
        // Navigate to another page when the text is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SmallMouse()),
        );
      },
      child: SizedBox(
        height: 25,
        child: Text(
          'SMALL MOUSE',
          style: GoogleFonts.mPlus1(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIcon({
    required IconData icon,
    required VoidCallback onPressed,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required BuildContext context,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: const Color.fromARGB(255, 0, 0, 0),
        size: 28,
      ),
    );
  }

 Widget _buildShoppingCartDrawer(BuildContext context) {
  final cartModel = context.watch<CartModel>();

  return Container(
    width: 250,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        left: BorderSide(color: Colors.grey),
      ),
    ),
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Text(
            'Shopping Cart',
            style: GoogleFonts.mPlus1(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ),
        for (int index = 0; index < cartModel.cartItems.length; index++)
          ListTile(
            title: Text(cartModel.cartItems[index]['ItemType']),
            subtitle: Text('Quantity: ${cartModel.cartItems[index]['ItemQuantity']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Total: ${cartModel.cartItems[index]['Total']}'),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Add logic to delete the item from the cart
                    cartModel.removeItem(index);
                  },
                ),
              ],
            ),
          ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: ElevatedButton(
            onPressed: cartModel.cartItems.isNotEmpty
                ? () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutPageWidget()),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green[400], // Text color
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Checkout',
                style: GoogleFonts.mPlus1(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}



  Widget buildSideMenu(
  BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
  double screenWidth = MediaQuery.of(context).size.width;
  User? user = FirebaseAuth.instance.currentUser;

  return Container(
    width: 300,
    color: Color.fromARGB(255, 253, 253, 253),
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          if (user == null)
            Text(
              'Welcome, User',
              style: GoogleFonts.mPlus1(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        SizedBox(height: 48),
        ElevatedButton(
          onPressed: () {
            _logout(context);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green[400], // Text color
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Go back to LOGIN',
            style: GoogleFonts.mPlus1(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        
        // Other content as needed
      ],
    ),
  );
}

  Widget _buildIconsRow(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return Row(
        children: [
          _buildHeaderIcon(
            icon: Icons.person_2_outlined,
            onPressed: () {
              scaffoldKey.currentState!.openDrawer(); // Open the drawer
            },
            scaffoldKey: scaffoldKey,
            context: context,
          ),
          _buildHeaderIcon(
            icon: Icons.shopping_cart_outlined,
            onPressed: () {
              scaffoldKey.currentState!
                  .openEndDrawer(); // Open the shopping cart drawer
            },
            scaffoldKey: scaffoldKey,
            context: context,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          _buildHeaderIcon(
            icon: Icons.email_outlined,
            onPressed: () {
              _showEmailDialog(context); // Show the email dialog
            },
            scaffoldKey: scaffoldKey,
            context: context,
          ),
          _buildHeaderIcon(
            icon: Icons.person_2_outlined,
            onPressed: () {
              scaffoldKey.currentState!.openDrawer(); // Open the drawer
            },
            scaffoldKey: scaffoldKey,
            context: context,
          ),
          _buildHeaderIcon(
            icon: Icons.shopping_cart_outlined,
            onPressed: () {
              scaffoldKey.currentState!
                  .openEndDrawer(); // Open the shopping cart drawer
            },
            scaffoldKey: scaffoldKey,
            context: context,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return isLoading
        ? LoadingWidget()
        : Scaffold(
            drawer: buildSideMenu(context, _scaffoldKey), // Add the drawer here
            key: _scaffoldKey,
            endDrawer: _buildShoppingCartDrawer(context),
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: AppBar(
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
                actions: [
                  _buildIconsRow(
                      context, _scaffoldKey), // Pass the context here
                ],
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
                          Spacer(),
                          _HeaderText(
                            label: 'PRODUCTS',
                            onPressed: () {
                              setState(() {
                                _showProductNavBar = !_showProductNavBar;
                                _showAdditionalText = !_showAdditionalText;
                              });
                            },
                            scaffoldKey: _scaffoldKey,
                            context: context,
                          ),
                          const SizedBox(
                              width: 8), // Adjust the width as desired
                          _HeaderText(
                            label: 'ABOUT',
                            onPressed: () {
                              // Handle ABOUT action
                            },
                            scaffoldKey: _scaffoldKey,
                            context: context,
                          ),
                          const SizedBox(
                              width: 8), // Adjust the width as desired
                          _HeaderText(
                            label: 'CONTACT',
                            onPressed: () {
                              // Handle CONTACT action
                            },
                            scaffoldKey: _scaffoldKey,
                            context: context,
                          ),
                          Spacer(),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 600) {
                  // Desktop view
                  _showAdditionalText =
                      false; // Reset the variable for desktop view
                  return SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: _showProductNavBar ? 100 : 0,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              color: Colors.white70,
                              child: _showProductNavBar
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: _HeaderText(
                                            label: 'LARGE MOUSE',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      LargeMouse(),
                                                ),
                                              );
                                            },
                                            scaffoldKey: _scaffoldKey,
                                            context: context,
                                          ),
                                        ),
                                        SizedBox(width: 32),
                                        Expanded(
                                          child: _HeaderText(
                                            label: 'MEDIUM MOUSE',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MediumMouse(),
                                                ),
                                              );
                                            },
                                            scaffoldKey: _scaffoldKey,
                                            context: context,
                                          ),
                                        ),
                                        SizedBox(width: 32),
                                        Expanded(
                                          child: _HeaderText(
                                            label: 'SMALL MOUSE',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SmallMouse(),
                                                ),
                                              );
                                            },
                                            scaffoldKey: _scaffoldKey,
                                            context: context,
                                          ),
                                        ),
                                      ],
                                    )
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/homepage-lamzu.gif'),
                                  fit: BoxFit
                                      .cover, // Adjust the fit based on your requirements
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      'LAMZU',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mPlus1(
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 50,
                                        color:
                                            Color.fromARGB(128, 150, 150, 150),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            10), // Adding some space between the texts
                                    Flexible(
                                      child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (context, child) {
                                          return Text(
                                            'Your choice is yours now',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.mPlus1(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  128,
                                                  150,
                                                  150,
                                                  150), // Example style for the additional text
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  /*  image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/homepage-lamzu.gif'),
                                          fit: BoxFit.cover,
                                        ), */
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(25.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'About us',
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.mPlus1(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25,
                                          fontStyle: FontStyle.italic,
                                          color: const Color.fromARGB(
                                              190, 145, 145, 145),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.only(left: 780.0),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              "We're a team of passionate professionals dedicated to crafting top-tier peripheral products. Our group comprises seasoned FPS gamers, skilled designers, adept supply chain managers, and structural engineers, along with avid DIY enthusiasts. When it comes to gaming mice, preferences like click feel, grip, sound, touch, shape, and style are highly subjective. No single product can cater to everyone's needs, resulting in a diverse range of niche and well-known brands like Zowie, Logitech, Razer, and SteelSeries.",
                                              textAlign: TextAlign.justify,
                                              textStyle: GoogleFonts.mPlus1(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 17,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                           // Display shopping cart
                        
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF2F4),
                              border:
                                  Border.all(color: const Color(0xFFDDE1E6)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
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
                    ),
                  );
                } else {
                  // Mobile view
                  _showProductNavBar =
                      false; // Reset the variable for mobile view
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[200],
                          // Your body content goes here for mobile view
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF2F4),
                          border: Border.all(color: const Color(0xFFDDE1E6)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                  );
                }
              },
            ));
  }
}

class _HeaderText extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _HeaderText({
    Key? key,
    required this.label,
    required this.onPressed,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required BuildContext context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0), // Adjust the padding as desired
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
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

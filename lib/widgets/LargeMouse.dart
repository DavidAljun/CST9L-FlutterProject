import 'dart:async';

import 'package:admin_page/pages/checkoutpage.dart';
import 'package:admin_page/pages/homepage.dart';
import 'package:admin_page/pages/loginpage.dart';
import 'package:admin_page/pages/registerpage.dart';
import 'package:admin_page/widgets/SmallMouse.dart';
import 'package:admin_page/widgets/MediumMouse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin_page/widgets/LoadingMode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => RegisterPageWidget(),
      '/home': (context) => HomePageWidget(),
      '/login': (context) => LoginPageWidget(),
      '/checkout': (context) => CheckoutPageWidget(),
    },
  ));
}

enum WidgetType {
  LamzuThorn,
  LamzuMaya,
  // Add more widget types here if needed
}

Map<WidgetType, Widget Function()> widgetBuilders = {
  WidgetType.LamzuThorn: () => MediumMouse(),
  WidgetType.LamzuMaya: () => SmallMouse(),
  // Add more mappings for other widget types if needed
};

class LargeMouse extends StatefulWidget {
  const LargeMouse({Key? key}) : super(key: key);

  @override
  State<LargeMouse> createState() => _MyLargeMouse();
}

class _MyLargeMouse extends State<LargeMouse>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showAdditionalText = false;
  bool _isShoppingCartOpen = false;
  late AnimationController _controller;
  final PageController _pageController = PageController();
  bool _showProductNavBar = false;
  int _currentPage = 0;
  bool isSizeExpanded = false;
  bool isSpecificationExpanded = false;
  List<Map<String, dynamic>> documents = [];
  int currentDocumentIndex = 0;
  int simpleDoubleInput = 1;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _adminTable =
      FirebaseFirestore.instance.collection('adminTable');

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300), // Define the animation duration
    );
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('adminTable')
              .where('DocumentID', isEqualTo: 'LARGE MOUSE')
              .where('ItemQuantity',
                  isGreaterThan:
                      0) // Filter out items with ItemQuantity equal to 0
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        setState(() {
          documents = querySnapshot.docs.map((doc) => doc.data()).toList();
          isLoading = false;
        });
      } else {
        // Handle case where no documents are found
        print('No document found with DocumentID: LARGE MOUSE');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error
    }
  }

  Future<void> showAddToCartDialog(BuildContext context) async {
  final Completer<void> completer = Completer<void>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Product Added to the Cart',
          style: GoogleFonts.mPlus1(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Item is Successfully Added to the Cart',
          style: GoogleFonts.mPlus1(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              completer.complete(); // Signal completion when the button is pressed
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
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      );
    },
  );

  return completer.future;
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
      },
      child: SizedBox(
        height: 25,
        child: Text(
          'LAMZU ATLANTIS MINI',
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
        setState(() {
          simpleDoubleInput = 1;
        });
        _getNextDocument();
      },
      child: SizedBox(
        height: 25,
        child: Text(
          'LAMZU THORN',
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
        setState(() {
          simpleDoubleInput = 2;
        });
        _getNextDocument();
      },
      child: SizedBox(
        height: 25,
        child: Text(
          'LAMZU MAYA',
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

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(32.0),
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user != null)
                  Text(
                    'Welcome, ${user.displayName ?? "User"}',
                    style: GoogleFonts.mPlus1(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (user == null)
                  Text(
                    'Welcome, Guest',
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
              ],
            ),
          ),
          if (screenWidth < 600) ...[
            SizedBox(height: 20),
            _HeaderText(
              label: 'PRODUCTS',
              onPressed: () {
                setState(() {
                  _showAdditionalText = !_showAdditionalText;
                });
              },
              scaffoldKey: scaffoldKey,
              context: context,
            ),
            if (_showAdditionalText) ...[
              SizedBox(height: 7),
              _buildClickableTextOnLamzuAtlantis(),
              SizedBox(height: 7),
              _buildClickableTextOnLamzuThorn(),
              SizedBox(height: 7),
              _buildClickableTextOnLamzuMaya(),
            ],
            SizedBox(height: 20),
            _HeaderText(
              label: 'ABOUT',
              onPressed: () {
                // Handle ABOUT action
              },
              scaffoldKey: scaffoldKey,
              context: context,
            ),
            SizedBox(height: 20),
            _HeaderText(
              label: 'CONTACT',
              onPressed: () {
                // Handle CONTACT action
              },
              scaffoldKey: scaffoldKey,
              context: context,
            ),
          ],
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

  bool isLoading = false;

  void fetchData(BuildContext context, WidgetType widgetType) async {
    setState(() {
      isLoading = true;
    });

    // Simulate some async task
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

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

    if (!isLoading) {
      // Retrieve the corresponding widget builder function from the map
      Widget Function()? builder = widgetBuilders[widgetType];

      if (builder != null) {
        // Call the builder function to create the widget
        Widget widget = builder();

        // Navigate or perform action with the created widget
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget),
        );
      }
    }
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
  Widget build(BuildContext context) {
    var cartModel = Provider.of<CartModel>(context, listen: false);
    if (documents.isEmpty || currentDocumentIndex >= documents.length) {
      // Handle the case where documents are empty or the index is out of bounds
      return LoadingWidget(); // or another error message or widget
    }
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
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the homepage
                      Navigator.pushNamed(context, "/home");
                    },
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
                              //
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
                  return Column(
                    children: [
                      SizedBox(
                        height: _showProductNavBar ? 100 : 0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          color: Colors.white70,
                          child: _showProductNavBar
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: _HeaderText(
                                        label: 'LAMZU ATLANTIS MINI',
                                        onPressed: () {},
                                        scaffoldKey: _scaffoldKey,
                                        context: context,
                                      ),
                                    ),
                                    SizedBox(width: 32),
                                    Expanded(
                                      child: _HeaderText(
                                        label: 'LAMZU THRON',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MediumMouse()),
                                          );
                                        },
                                        scaffoldKey: _scaffoldKey,
                                        context: context,
                                      ),
                                    ),
                                    SizedBox(width: 32),
                                    Expanded(
                                      child: _HeaderText(
                                        label: 'LAMZU MAYA',
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SmallMouse()),
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
                      Flexible(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  color: Colors.black87,
                                  height: 415,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      documents[currentDocumentIndex]
                                              ['ItemType'] ??
                                          '',
                                      style: GoogleFonts.mPlus1(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      '₱${documents[currentDocumentIndex]['Price'] ?? 0}',
                                      style: GoogleFonts.mPlus1(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Row(
                                      children: List.generate(
                                        4,
                                        (index) => Container(
                                          color: Colors.grey,
                                          width: 30.0,
                                          height: 30.0,
                                          margin: EdgeInsets.only(
                                            right: 8.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Quantity', // Price
                                      style: GoogleFonts.mPlus1(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    QuantityInput(
                                      value: simpleDoubleInput,
                                      maxValue: documents[currentDocumentIndex]
                                              ['ItemQuantity'] ??
                                          1,
                                      onChanged: (value) {
                                        setState(() {
                                          simpleDoubleInput = int.parse(
                                              value.replaceAll(',', '')) as int;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 16.0),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              final cartModel =
                                                  context.read<CartModel>();
                                              final currentItem = documents[
                                                  currentDocumentIndex];
                                              if (simpleDoubleInput > 0) {
                                                cartModel.addToCart({
                                                  'ItemType':
                                                      currentItem['ItemType'],
                                                  'ItemQuantity':
                                                      simpleDoubleInput,
                                                  'Price': currentItem['Price'],
                                                  'Total': simpleDoubleInput *
                                                      currentItem['Price'],
                                                });
                                                showAddToCartDialog(context);
                                              } else {
                                                // Show a message that item quantity is zero
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text(
                                                          'Item Quantity is Zero'),
                                                      actions: [
                                                        
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                              textStyle: GoogleFonts.mPlus1(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Text(
                                              'Add to Cart',
                                              style: GoogleFonts.mPlus1(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                simpleDoubleInput = 0;
                                              });
                                              _getNextDocument();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                              textStyle: GoogleFonts.mPlus1(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Text(
                                              'NEXT',
                                              style: GoogleFonts.mPlus1(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 16.0),
                                    // Show/Hide widget for Size
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Other widgets...

                                          // Space between previous widgets and Lorem Ipsum section
                                          SizedBox(height: 16.0),

                                          // Centered ExpansionTile for Size (Wrapped in Center)
                                          Center(
                                            child: ExpansionTile(
                                              title: Text(
                                                'Dimension and Specification',
                                                style: GoogleFonts.mPlus1(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              initiallyExpanded: isSizeExpanded,
                                              onExpansionChanged: (value) {
                                                setState(() {
                                                  isSizeExpanded = value;
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 24),
                                        ],
                                      ),
                                    ),
                                    /* ElevatedButton(
                                      onPressed: () {
                                    setState(() {
                                      simpleDoubleInput = 1;
                                    });
                                    _getNextDocument();
                                  },
                                      child: Text('Next'),
                                    ), */
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF2F4),
                          border: Border.all(
                            color: const Color(0xFFDDE1E6),
                          ),
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
                } else {
                  // Mobile view
                  _showProductNavBar =
                      false; // Reset the variable for mobile view
                  _showAdditionalText =
                      false; // Reset the variable for desktop view
                  return SingleChildScrollView(
                      child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Adjustments for smaller screens
                          SizedBox(height: 16.0),
                          Container(
                            color:
                                Colors.black87, // Placeholder for product image
                            height: 300, // Adjust height for smaller screens
                            width: double
                                .infinity, // Adjust width for smaller screens
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            documents[currentDocumentIndex]['ItemType'] ?? '',
                            style: GoogleFonts.mPlus1(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '₱${documents[currentDocumentIndex]['Price'] ?? 0}',
                            style: GoogleFonts.mPlus1(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Placeholder images
                              for (int i = 0; i < 4; i++)
                                Container(
                                  color: Colors
                                      .grey, // Placeholder for selectable images
                                  width: 70.0,
                                  height: 70.0,
                                  margin: EdgeInsets.only(right: 8.0),
                                ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Quantity', // Price
                            style: GoogleFonts.mPlus1(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          QuantityInput(
                            value: simpleDoubleInput,
                            maxValue: documents[currentDocumentIndex]
                                    ['ItemQuantity'] ??
                                0,
                            onChanged: (value) {
                              setState(() {
                                simpleDoubleInput =
                                    int.parse(value.replaceAll(',', '')) as int;
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          // Elevated Button for Add to Cart
                          Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              final cartModel =
                                                  context.read<CartModel>();
                                              final currentItem = documents[
                                                  currentDocumentIndex];
                                              if (simpleDoubleInput > 0) {
                                                cartModel.addToCart({
                                                  'ItemType':
                                                      currentItem['ItemType'],
                                                  'ItemQuantity':
                                                      simpleDoubleInput,
                                                  'Price': currentItem['Price'],
                                                  'Total': simpleDoubleInput *
                                                      currentItem['Price'],
                                                });
                                                showAddToCartDialog(context);
                                              } else {
                                                // Show a message that item quantity is zero
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text(
                                                          'Item Quantity is Zero'),
                                                      actions: [
                                                        
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                              textStyle: GoogleFonts.mPlus1(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Text(
                                              'Add to Cart',
                                              style: GoogleFonts.mPlus1(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          onPressed: () {
                                    setState(() {
                                      simpleDoubleInput = 1;
                                    });
                                    _getNextDocument();
                                  },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 12),
                                              textStyle: GoogleFonts.mPlus1(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            child: Text(
                                              'NEXT',
                                              style: GoogleFonts.mPlus1(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 16.0),// Show/Hide widget for Size
                          ExpansionTile(
                            title: Text(
                              'Dimension',
                              style: GoogleFonts.mPlus1(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            initiallyExpanded: isSizeExpanded,
                            onExpansionChanged: (value) {
                              setState(() {
                                isSizeExpanded = value;
                              });
                            },
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Length: 4.60in (117mm)',
                                        style: GoogleFonts.mPlus1(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Width: 2.48in (63mm)',
                                        style: GoogleFonts.mPlus1(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Height: 1.45in (37mm)',
                                        style: GoogleFonts.mPlus1(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          // ExpansionTile for Specification
                          ExpansionTile(
                            title: Text(
                              'Specification',
                              style: GoogleFonts.mPlus1(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            initiallyExpanded: isSpecificationExpanded,
                            onExpansionChanged: (value) {
                              setState(() {
                                isSpecificationExpanded = value;
                              });
                            },
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 9.5),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Ambidextrous Shape with Comfort Grooves & ultra light weight wireless mouse",
                                        textAlign: TextAlign.justify,
                                        textDirection: TextDirection.ltr,
                                        style: GoogleFonts.mPlus1(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 9.5),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "PAW3395 optical sensor and No-lag wireless connectivity",
                                        textAlign: TextAlign.justify,
                                        textDirection: TextDirection.ltr,
                                        style: GoogleFonts.mPlus1(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 9.5),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        "Supports up to 26000 DPI with High battery life up to 70 hours",
                                        textAlign: TextAlign.justify,
                                        textDirection: TextDirection.ltr,
                                        style: GoogleFonts.mPlus1(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 9),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]),
                  ));
                }
              },
            ));
  }

  void _getNextDocument() {
    setState(() {
      if (currentDocumentIndex < documents.length - 1) {
        currentDocumentIndex++;
      } else {
        currentDocumentIndex = 0;
      }
    });
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

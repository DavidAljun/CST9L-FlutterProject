import 'package:flutter/material.dart';
import 'package:admin_page/pages/homepage.dart';
import 'package:admin_page/widgets/LoadingMode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:admin_page/widgets/cart_model.dart';

void main() {
  runApp(MaterialApp(
    home: HomePageWidget(),
  ));
}

// ignore: must_be_immutable
class CheckoutPageWidget extends StatefulWidget {
  CheckoutPageWidget({Key? key}) : super(key: key);

  @override
  State<CheckoutPageWidget> createState() => _CheckoutPageWidgetState();
}

class _CheckoutPageWidgetState extends State<CheckoutPageWidget> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool creditCardChecked = false;
  bool cashOnDeliveryChecked = false;
  bool onlineBankChecked = false;

  bool get isAnyPaymentSelected =>
      creditCardChecked || cashOnDeliveryChecked || onlineBankChecked;

  final OrderModel _orderModel = OrderModel(
    itemType: 'Sample Item',
    itemQuantity: 1,
    total: 10.0,
  );

  bool isLoading = false;

  void fetchData() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 10),
                child: GestureDetector(
                  onTap: () {
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
            body: Padding(
              padding: EdgeInsets.only(
                  right: 750.0), // Adjust left padding as needed
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Section
                    Text(
                      'Contact',
                      style: GoogleFonts.mPlus1(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                      controller: _emailController,
                    ),
                    SizedBox(height: 20),

                    // Delivery Section
                    Text(
                      'Delivery',
                      style: GoogleFonts.mPlus1(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'First Name',
                            ),
                            controller: _firstNameController,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name',
                            ),
                            controller: _lastNameController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Address',
                      ),
                      controller: _addressController,
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (bool? newValue) {
                            // Implement logic when checkbox state changes
                          },
                        ),
                        Text(
                          'Save For Future Purchases',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Payment Section
                    Text(
                      'Payment',
                      style: GoogleFonts.mPlus1(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Credit Card/Debit Card',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      value: creditCardChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          creditCardChecked = newValue ?? false;
                          if (creditCardChecked) {
                            cashOnDeliveryChecked = false;
                            onlineBankChecked = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Cash on Delivery',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      value: cashOnDeliveryChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          cashOnDeliveryChecked = newValue ?? false;
                          if (cashOnDeliveryChecked) {
                            creditCardChecked = false;
                            onlineBankChecked = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        'Online Bank',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      value: onlineBankChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          onlineBankChecked = newValue ?? false;
                          if (onlineBankChecked) {
                            creditCardChecked = false;
                            cashOnDeliveryChecked = false;
                          }
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    
                    // PLACE ORDER Button
                    ElevatedButton(
                      onPressed: isAnyPaymentSelected
                          ? () async {
                              if (await isEmailExists(_emailController.text)) {
                                await placeOrder();
                              } else {
                                // Show an error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Email not found!'),
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green[400],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'PLACE ORDER',
                        style: GoogleFonts.mPlus1(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
  }
  Future<bool> isEmailExists(String email) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('customerList')
          .where('email', isEqualTo: email)
          .get();

      return result.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email existence: $e');
      return false;
    }
  }

  Future<void> placeOrder() async {
  try {
    final cartModel = context.read<CartModel>();

    String email = _emailController.text;
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String address = _addressController.text;

    final List<Map<String, dynamic>> cartItems = cartModel.cartItems;

    double total = 0;
    cartItems.forEach((item) {
      total += item['Total'] as double;
    });

    // Update adminTable documents based on the items in the cart
    for (final item in cartItems) {
      final itemType = item['ItemType'] as String;
      final itemQuantity = item['ItemQuantity'] as int;

      await updateAdminTable(itemType, itemQuantity);
    }

    await FirebaseFirestore.instance.collection('OrderList').add({
      'Email': email,
      'FirstName': firstName,
      'LastName': lastName,
      'Address': address,
      'Items': cartItems,
      'Total': total,
      'Action': 'Pending', // Add the Action field here
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order placed successfully!'),
      ),
    );

    clearShoppingCart();

    Navigator.of(context).pop();
  } catch (e) {
    print('Error placing order: $e');
  }
}

Future<void> updateAdminTable(String itemType, int itemQuantity) async {
  try {
    final adminTableRef =
        FirebaseFirestore.instance.collection('adminTable');

    // Retrieve the document that matches the itemType
    final querySnapshot = await adminTableRef
        .where('ItemType', isEqualTo: itemType)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Update the ItemQuantity in the document
      final doc = querySnapshot.docs.first;
      final currentQuantity = doc['ItemQuantity'] as int;
      final updatedQuantity = currentQuantity - itemQuantity;

      // Update the document in adminTable
      await adminTableRef.doc(doc.id).update({
        'ItemQuantity': updatedQuantity,
      });
    }
  } catch (e) {
    print('Error updating adminTable: $e');
  }
}

  void clearShoppingCart() {
    final cartModel = context.read<CartModel>();
    cartModel.clearCart();
  }
}

class _HeaderText extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _HeaderText({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
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
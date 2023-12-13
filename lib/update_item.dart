import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Uitem extends StatefulWidget {
  final int itemId;
  final String initialItemType;
  final int initialItemQuantity;
  final double initialPrice;

  Uitem({
    required this.itemId,
    required this.initialItemType,
    required this.initialItemQuantity,
    required this.initialPrice,
  });

  @override
  _UitemState createState() => _UitemState();
}

class _UitemState extends State<Uitem> {
  late TextEditingController itemTypeController;
  late TextEditingController itemQuantityController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    itemTypeController = TextEditingController(text: widget.initialItemType);
    itemQuantityController = TextEditingController(text: widget.initialItemQuantity.toString());
    priceController = TextEditingController(text: widget.initialPrice.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: itemTypeController,
              decoration: InputDecoration(labelText: 'Item Type'),
            ),
            TextField(
              controller: itemQuantityController,
              decoration: InputDecoration(labelText: 'Item Quantity'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateItem(widget.itemId);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

 void _updateItem(int itemId) async {
  try {
    // Query for the document with the specified ItemID
    var querySnapshot = await FirebaseFirestore.instance
        .collection('adminTable')
        .where('ItemID', isEqualTo: itemId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Document found, perform the update
      var document = querySnapshot.docs.first;
      await document.reference.update({
        'ItemType': itemTypeController.text,
        'ItemQuantity': int.parse(itemQuantityController.text),
        'Price': double.parse(priceController.text),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item updated successfully'),
        ),
      );

      // Return a value indicating the item was updated
      Navigator.pop(context, true);
    } else {
      // Document not found, show an error message or take appropriate action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Item not found for update'),
        ),
      );

      // Return a value indicating the item was not updated
      Navigator.pop(context, false);
    }
  } catch (error) {
    print("Error updating item: $error");
    // You might want to show an error message to the user in case of an exception

    // Return a value indicating the item was not updated
    Navigator.pop(context, false);
  }
}





}

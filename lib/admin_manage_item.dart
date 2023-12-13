 import 'dart:math';
import 'package:admin_page/update_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Amanage extends StatefulWidget {
  const Amanage({Key? key}) : super(key: key);

  @override
  _AmanageState createState() => _AmanageState();
}

class _AmanageState extends State<Amanage> {
  double fem = 1.0;
  double ffem = 0.97;

  TextEditingController itemTypeController = TextEditingController();
  TextEditingController itemQuantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(49 * fem, 34 * fem, 660 * fem, 31 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff2a2882),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 39 * fem, 4 * fem),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30 * fem,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/admin_dashboard');
                        },
                      ),
                    ),
                    Text(
                      'MANAGE ITEM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 48 * ffem,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(26 * fem, 7 * fem, 26 * fem, 30 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 250 * fem, 12 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () => showAddDialog(context),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 10 * fem, 0 * fem),
                              primary: Color(0xbf46248f),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20 * fem),
                              ),
                            ),
                            child: Container(
                              width: 100 * fem,
                              height: 33 * fem,
                              child: Center(
                                child: Text(
                                  'ADD',
                                  style: TextStyle(
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0 * fem, 5 * fem, 0 * fem, 0 * fem),
                            padding: EdgeInsets.fromLTRB(300 * fem, 0 * fem, 10 * fem, 0 * fem),
                            child: Text(
                              'LIST OF ITEM ADDED:',
                              style: TextStyle(
                                fontSize: 25 * ffem,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(26 * fem, 7 * fem, 26 * fem, 30 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 250 * fem, 12 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(6 * fem, 0 * fem, 0 * fem, 38 * fem),
                                    width: 346 * fem,
                                    height: 233 * fem,
                                    child: Image.asset(
                                      '../assets/figmaMouse.webp',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add your image choosing logic here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                      primary: Color(0xb546248f),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20 * fem),
                                      ),
                                    ),
                                    child: Container(
                                      width: 301 * fem,
                                      height: 63 * fem,
                                      child: Center(
                                        child: Text(
                                          'CHOOSE PICTURE',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0x7f000000),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(26 * fem, 20 * fem, 0 * fem, 16 * fem),
                                    padding: EdgeInsets.fromLTRB(16 * fem, 20 * fem, 16 * fem, 15 * fem),
                                    width: 296 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xffd9d9d9),
                                    ),
                                    child: TextField(
                                      controller: itemTypeController,
                                      decoration: InputDecoration(
                                        labelText: 'ITEM TYPE',
                                        labelStyle: TextStyle(
                                          fontSize: 24 * ffem,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0x7f000000),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(26 * fem, 0 * fem, 0 * fem, 0 * fem),
                                    padding: EdgeInsets.fromLTRB(16 * fem, 20 * fem, 16 * fem, 15 * fem),
                                    width: 296 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xffd9d9d9),
                                    ),
                                    child: TextField(
                                      controller: itemQuantityController,
                                      decoration: InputDecoration(
                                        labelText: 'ITEM QUANTITY',
                                        labelStyle: TextStyle(
                                          fontSize: 24 * ffem,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0x7f000000),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(26 * fem, 20 * fem, 0 * fem, 16 * fem),
                                    padding: EdgeInsets.fromLTRB(16 * fem, 20 * fem, 16 * fem, 15 * fem),
                                    width: 296 * fem,
                                    decoration: BoxDecoration(
                                      color: Color(0xffd9d9d9),
                                    ),
                                    child: TextField(
                                      controller: priceController,
                                      decoration: InputDecoration(
                                        labelText: 'PRICE',
                                        labelStyle: TextStyle(
                                          fontSize: 24 * ffem,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0x7f000000),
                                        ),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
  child: Padding(
    padding: const EdgeInsets.fromLTRB(90.0, 20.0, 0.0, 100.0),
    child: SizedBox(
      width: 500,
      child: FutureBuilder(
        // Use FutureBuilder to handle asynchronous fetching
        future: _fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return PaginatedDataTable(
              header: Text('Items'),
              columns: [
                DataColumn(label: Text('Item ID')),
                DataColumn(label: Text('Item Type')),
                DataColumn(label: Text('Item Quantity')),
                DataColumn(label: Text('Price')), // New column for Price
                DataColumn(
                  label: Row(
                    children: [
                      Text('Action'),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () async {
                          // Refresh the data by calling _fetchData again
                          await _fetchData();
                          // Rebuild the widget to reflect the changes
                          setState(() {});
                        },
                        child: Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  numeric: false,
                  tooltip: 'Actions',
                  onSort: (int columnIndex, bool ascending) {
                    // Implement sorting if needed
                  },
                ),
              ],
              source: _AmanageDataSource(snapshot.data ?? [], context, this),
              rowsPerPage: 5,
              dataRowHeight: 80.0,
              headingRowHeight: 70.0,
              columnSpacing: 20.0,
              horizontalMargin: 20.0,
            );
          }
        },
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
    );
  }

  Future<List<Map<String, dynamic>>> _fetchData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('adminTable').get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return {
          'ItemID': data['ItemID'] ?? 0,
          'ItemType': data['ItemType'] ?? '',
          'ItemQuantity': data['ItemQuantity'] ?? 0,
          'Price': data['Price'] ?? 0.0,
        };
      }).toList();
    } catch (error) {
      print("Error fetching data: $error");
      throw error; // Rethrow the error for the FutureBuilder to catch
    }
  }

  void showAddDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Document ID'),
        content: Column(
          children: [
            ListTile(
              title: Text('LARGE MOUSE'),
              onTap: () {
                Navigator.pop(context, 'LARGE MOUSE');
              },
            ),
            ListTile(
              title: Text('SMALL MOUSE'),
              onTap: () {
                Navigator.pop(context, 'SMALL MOUSE');
              },
            ),
            ListTile(
              title: Text('MEDIUM MOUSE'),
              onTap: () {
                Navigator.pop(context, 'MEDIUM MOUSE');
              },
            ),
          ],
        ),
      );
    },
  ).then((chosenDocumentId) {
    if (chosenDocumentId != null) {
      // The user has chosen a document ID, now you can proceed to add the item
      addItemWithDocumentId(context, chosenDocumentId);
    }
  });
}


   

 void addItemWithDocumentId(BuildContext context, String chosenDocumentId) async {
  try {
    await FirebaseFirestore.instance.collection('adminTable').add({
      'DocumentID': chosenDocumentId, // Store the chosen document ID as a field
      'ItemID': Random().nextInt(1000), // Replace this with your logic for generating ItemID
      'ItemType': itemTypeController.text,
      'ItemQuantity': int.parse(itemQuantityController.text),
      'Price': double.parse(priceController.text),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item added successfully'),
      ),
    );

    // Clear the text fields after adding the item
    itemTypeController.clear();
    itemQuantityController.clear();
    priceController.clear();

    // Update the UI by calling the setState method
    setState(() {
      // Refresh the data by calling _fetchData again
      _fetchData();
    });
  } catch (error) {
    print("Error adding item: $error");
  }
}

}

// Add this class to handle data source for Amanage DataTable
class _AmanageDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;
  final BuildContext context;
  final _AmanageState _amangeState;

  _AmanageDataSource(this._data, this.context, this._amangeState);

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(_data[index]['ItemID'].toString())),
        DataCell(Text(_data[index]['ItemType'].toString())),
        DataCell(Text(_data[index]['ItemQuantity'].toString())),
        DataCell(Text(_data[index]['Price'].toString())),
        DataCell(
  Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
  onPressed: () async {
    // Navigate to Uitem screen with selected item's data
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Uitem(
          itemId: _data[index]['ItemID'],
          initialItemType: _data[index]['ItemType'],
          initialItemQuantity: _data[index]['ItemQuantity'],
          initialPrice: _data[index]['Price'],
        ),
      ),
    );

    // Check the result and refresh the table if the item was updated
    if (result != null && result) {
      _amangeState._fetchData(); // Call your method to refresh the table data
    }
  },
  child: Text('Update'),
),

        SizedBox(height: 3),
        ElevatedButton(
          onPressed: () {
            _deleteItem(_data[index]['ItemID']);
          },
          child: Text('Delete'),
        ),
      ],
    ),
  ),
),
      ],
    );
  }

  void _deleteItem(int itemId) async {
    try {
      await FirebaseFirestore.instance.collection('adminTable').where('ItemID', isEqualTo: itemId).get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Item deleted successfully'),
        ),
      );

      // Update the UI by calling the setState method in the _AmanageState
      _amangeState.setState(() {
        // Refresh the data by calling _fetchData again
        _amangeState._fetchData();
      });
    } catch (error) {
      print("Error deleting item: $error");
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
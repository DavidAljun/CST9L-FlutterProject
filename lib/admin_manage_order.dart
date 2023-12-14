import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AMorder extends StatelessWidget {
  const AMorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('OrderList').get(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Map<String, dynamic>> orders = snapshot.data!.docs.map((DocumentSnapshot doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          int totalQuantity = data['Items'].fold(0, (prev, item) => prev + item['ItemQuantity']);
          return {
            'DocumentID': doc.id, // Store the document ID
            'Email': data['Email'],
            'FirstName': data['FirstName'],
            'LastName': data['LastName'],
            'Address': data['Address'],
            'OrderQuantity': totalQuantity,
            'Total': data['Total'],
            'Action': data['Action'],
          };
        }).toList();

        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 325),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    padding: EdgeInsets.fromLTRB(43, 41, 440, 44),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff2a2882),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
  child: IconButton(
    icon: Icon(
      Icons.arrow_back,
      size: 10,
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.pushNamed(context, '/admin_dashboard');
    },
  ),
)
                        Text(
                          ' Admin manage order page',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            height: 1.2125,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 135,
                    height: 29,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 77,
                          top: 0,
                          child: Align(
                            child: SizedBox(
                              width: 51,
                              height: 16,
                              child: Text(
                                'Mouse1 \n',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2125,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 4,
                          child: Align(
                            child: SizedBox(
                              width: 135,
                              height: 25,
                              child: Text(
                                'All Orders (${orders.length})',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2125,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: PaginatedDataTable(
                      header: Text('Order Data'),
                      rowsPerPage: 5,
                      columns: [
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('FirstName')),
                        DataColumn(label: Text('LastName')),
                        DataColumn(label: Text('Address')),
                        DataColumn(label: Text('Order Quantity')),
                        DataColumn(label: Text('Total')),
                        DataColumn(
                          label: Text('Action'),
                          numeric: false,
                          tooltip: 'Actions',
                          onSort: (int columnIndex, bool ascending) {
                            // Implement sorting if needed
                          },
                        ),
                      ],
                      source: _AMorderDataSource(orders),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AMorderDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;

  _AMorderDataSource(this._data);

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(_data[index]['Email'].toString())),
        DataCell(Text(_data[index]['FirstName'].toString())),
        DataCell(Text(_data[index]['LastName'].toString())),
        DataCell(Text(_data[index]['Address'].toString())),
        DataCell(Text(_data[index]['OrderQuantity'].toString())),
        DataCell(Text(_data[index]['Total'].toString())),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (_data[index]['Action'] == 'Deliver')
                TextButton(
                  onPressed: () {
                    _viewOrder(index); // Call the function to handle viewing
                  },
                  child: Text(
                    'Deliver',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (_data[index]['Action'] == 'Deliver') SizedBox(width: 50),
              ElevatedButton(
                onPressed: () {
                  _deliverOrder(index); // Call the function to handle delivery
                },
                child: Text(_data[index]['Action']),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _deliverOrder(int index) async {
    // Update the 'Action' attribute to 'Delivered Successfully'
    _data[index]['Action'] = 'Delivered Successfully';

    // Update 'Action' in Firestore
    String documentID = _data[index]['DocumentID']; // assuming you stored the document ID
    await FirebaseFirestore.instance.collection('OrderList').doc(documentID).update({
      'Action': 'Delivered Successfully',
    });

    // Notify listeners that the data has changed
    notifyListeners();
  }

  void _viewOrder(int index) {
    // Implement the logic to view the order details
    print('View order details for ${_data[index]['Email']}');
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}

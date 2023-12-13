import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Acustomer extends StatefulWidget {
  Acustomer({Key? key}) : super(key: key);

  @override
  _AcustomerState createState() => _AcustomerState();
}

class _AcustomerState extends State<Acustomer> {
  late Future<List<Map<String, dynamic>>> _customerData;

  @override
  void initState() {
    super.initState();
    _customerData = _fetchCustomerData();
  }

  Future<List<Map<String, dynamic>>> _fetchCustomerData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('customerList').get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 885;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _customerData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No customer data available.');
          }

          List<Map<String, dynamic>> customers = snapshot.data!;

          return ListView(
            children: [
              Container(
                height: 100 * fem,
                decoration: BoxDecoration(
                  color: Color(0xff2a2882),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 52 * fem,
                      top: 35 * fem,
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
                    Positioned(
                      left: 80 * fem,
                      top: 30 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 300 * fem,
                          height: 30 * fem,
                          child: Text(
                            'CUSTOMER LIST',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.2125 * ffem / fem,
                              color: Color(0xffffffff),
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
                  header: Text('Customer Data'),
                  rowsPerPage: 5,
                  columns: [
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('First Name')),
                    DataColumn(label: Text('Last Name')),
                  ],
                  source: _AmanageDataSource(customers),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AmanageDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;

  _AmanageDataSource(this._data);

  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(_data[index]['email'].toString())),
        DataCell(Text(_data[index]['firstName'].toString())),
        DataCell(Text(_data[index]['lastName'].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}

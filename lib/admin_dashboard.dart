import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Adashboard extends StatelessWidget {
  const Adashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1863;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
              colors: <Color>[Color(0xfff3f2f7), Color(0x00f3f2f7)],
              stops: <double>[0, 1],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 580.26 * fem),
                width: 400 * fem,
                height: 1200 * fem,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Admin Dashboard Logo and Title
                    Container(
                      margin: EdgeInsets.fromLTRB(38 * fem, 0 * fem, 108.9 * fem, 0 * fem),
                      width: 300 * fem,
                      height: 88.29 * fem,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 1.1027832031 * fem,
                            top: 63.2917480469 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 500 * fem,
                                height: 22 * fem,
                                child: Text(
                                  'Modern Admin Dashboard',
                                  style: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 18 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2 * ffem / fem,
                                    color: Color(0xffb9babd),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0 * fem,
                            top: 0 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 166 * fem,
                                height: 72 * fem,
                                child: Text(
                                  'Admin',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 48 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.5 * ffem / fem,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Menu Options
                    Container(
                      margin: EdgeInsets.only(left: 20.0),
                      padding: EdgeInsets.only(top: 15 * fem),
                      width: 300 * fem,
                      height: 218 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          
                          // Order List Option
                           buildMenuItem('Order List', fem, ffem, onTap: () {
      // Navigate to 'admin_manage_order.dart' when Order List is clicked
      Navigator.pushNamed(context, '/admin_manage_order');
    }),
                          // Customer List Option
                          buildMenuItem('Customer List', fem, ffem, onTap: () {
                            // Handle Customer List click
                            Navigator.pushNamed(context, '/admin_customer_list');
                          }),
                          // Manage Item Option
                          buildMenuItem('Manage Item', fem, ffem, onTap: () {
                            // Handle Manage Item click
                            Navigator.pushNamed(context, '/admin_manage_item');
                          }),
                          Align(
            alignment: Alignment.bottomLeft,
            
              child:ElevatedButton(
                            
                    onPressed: () {
                      // Navigate to the admin login screen
                      Navigator.pushNamed(context, '/admin_login');
                    },
                    child: Text(
                      'Exit',
                      style: TextStyle(
                        fontSize: 16 * ffem,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 17, 15, 15),
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

              // Right side content
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(35 * fem, 21 * fem, 10 * fem, 10 * fem), // Adjusted padding
                  width: MediaQuery.of(context).size.width - 349 * fem,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 33 * fem),
                        width: 301 * fem,
                        height: 71 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8 * fem),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 4 * fem,
                              top: 0 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 1.32 * fem,
                                  height: 71 * fem,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8 * fem),
                                      color: Color(0xffd0d5de),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0 * fem,
                              top: 0 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 233 * fem,
                                  height: 44 * fem,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Hello,',
                                          style: TextStyle(
                                            fontFamily: 'Barlow',
                                            fontSize: 36 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.2 * ffem / fem,
                                            color: Color(0xff464155),
                                          ),
                                        ),
                                        TextSpan(
                                          text: ' Adlawan',
                                          style: TextStyle(
                                            fontFamily: 'Barlow',
                                            fontSize: 36 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2 * ffem / fem,
                                            color: Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Dashboard',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Barlow',
                            fontSize: 96 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.2 * ffem / fem,
                            color: Color(0xff464155),
                          ),
                        ),
                      ),

                      // Line Chart
                      Container(
                        height: 200 * fem, // Adjust the height as needed
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(show: false),
                            borderData: FlBorderData(show: false),
                            minX: 0,
                            maxX: 7,
                            minY: 0,
                            maxY: 6,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 3),
                                  FlSpot(1, 1),
                                  FlSpot(2, 4),
                                  FlSpot(3, 2),
                                  FlSpot(4, 5),
                                  FlSpot(5, 3),
                                  FlSpot(6, 6),
                                  FlSpot(7, 4),
                                ],
                                isCurved: true,
                                colors: [Colors.blue],
                                dotData: FlDotData(show: false),
                                belowBarData: BarAreaData(show: false),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(String text, double fem, double ffem, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 25 * fem, 20 * fem),
        padding: EdgeInsets.fromLTRB(2.5 * fem, 0 * fem, 0 * fem, 0 * fem),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              '../assets/List.png',
              width: 25 * fem,
              height: 25 * fem,
            ),
            SizedBox(width: 10 * fem), // Add spacing between image and text
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Barlow',
                fontSize: 25 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.2 * ffem / fem,
                color: Color(0xff00b074),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

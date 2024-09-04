import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/models/user.module.dart';
import 'package:soul_connection/pages/subpages/widget/appbar.dart';
import 'package:soul_connection/pages/subpages/widget/drop_down_button.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key, required this.user});
  final UserModel user;

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  Map<String, dynamic> currentCustomer = {
    'name': 'Louis Delanata',
    'id': 1,
    'birthday': '02/03/2006',
    'address': '3 Rue de al Tour 34000 Montpelier, France'
  };

  List<Map<String, dynamic>> customers = [
    {
      'name': 'Louis Delanata',
      'id': 1,
      'birthday': '02/03/2006',
      'address': '3 Rue de al Tour 34000 Montpelier, France'
    },
    {
      'name': 'Romain Ruiz',
      'id': 2,
      'birthday': '09/06/2016',
      'address': '78 Rue de la mélinière 44200 Nantes, France'
    },
    {
      'name': 'Paul Boulanger',
      'id': 3,
      'birthday': '12/03/1999',
      'address': '26 Rue des bougainvilliers 97400 Saint-Denis, France'
    },
    {
      'name': 'Max Delanata',
      'id': 3,
      'birthday': '09/06/1996',
      'address': '34 Rue des pivoines 97400 Saint-Denis, France'
    },
  ];

  List<String> table1Labels = ['Date', 'Amount', 'Comment'];
  List<String> table2Labels = ['Date', 'Rating', 'Report', 'Source'];

  List<Map<String, dynamic>> contentTable1 = [
    {
      'date': '09/06/1996',
      'amount': '100€',
      'comment': 'Subscription',
    },
    {
      'date': '09/06/1996',
      'amount': '100€',
      'comment': 'Subscription',
    },
    {
      'date': '09/06/1996',
      'amount': '100€',
      'comment': 'Subscription',
    },
    {
      'date': '09/06/1996',
      'amount': '100€',
      'comment': 'Subscription',
    },
  ];

  List<Map<String, dynamic>> contentTable2 = [
    {
      'date': '09/06/1996',
      'rating': '3/5',
      'report': 'good moment',
      'source': 'Google',
    },
    {
      'date': '09/06/1996',
      'rating': '5/5',
      'report': 'Dating app',
      'source': 'Google',
    },
    {
      'date': '09/06/1996',
      'rating': '2/5',
      'report': 'cool',
      'source': 'All the bar',
    },
    {
      'date': '09/06/1996',
      'rating': '4/5',
      'report': 'nice',
      'source': 'yahoo',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appBar(context, 'Customers'),
        SizedBox(
          width: dw(context),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: dw(context) / 4 + 165,
                        child: CustomerDropdown(
                          customers: customers,
                          onCustomerChange:
                              (Map<String, dynamic> currentCustomer) {
                            setState(() {
                              this.currentCustomer = currentCustomer;
                            });
                          },
                        ),
                      ),
                      sh(20),
                      Row(
                        children: [
                          const Icon(Icons.emoji_people, color: Colors.black),
                          Text(
                            ' ${currentCustomer['name'] ?? ''}',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                            ),
                          ),
                        ],
                      ),
                      sh(5),
                      Row(
                        children: [
                          const Icon(Icons.cake, color: Colors.black),
                          Text(
                            ' ${currentCustomer['birthday'] ?? ''}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                            ),
                          ),
                        ],
                      ),
                      sh(5),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              color: Colors.black),
                          Text(
                            ' ${currentCustomer['address'] ?? ''}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.memory(
                    widget.user.profilePic!,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
        ),
        sh(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            height: 1,
            color: Colors.grey,
            width: dw(context),
          ),
        ),
        sh(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      'Payments',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: dw(context) / 3.5,
                    height: 179,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: SingleChildScrollView(
                      child: Table(
                        border: const TableBorder.symmetric(
                          inside: BorderSide(color: Colors.grey),
                        ),
                        children: [
                          for (int row = 0; row <= contentTable1.length; row++)
                            if (row == 0)
                              TableRow(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(9),
                                    topRight: Radius.circular(9),
                                  ),
                                ),
                                children: [
                                  for (int col = 0;
                                      col < table1Labels.length;
                                      col++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        table1Labels[col],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                ],
                              )
                            else
                              TableRow(
                                children: [
                                  for (int col = 0;
                                      col < table1Labels.length;
                                      col++)
                                    if (col == 0)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '$row',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          contentTable1[row - 1]
                                              [table1Labels[col].toLowerCase()],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              sw(30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      'Meetings',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: dw(context) / 2.3,
                    height: 179,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: SingleChildScrollView(
                      child: Table(
                        border: const TableBorder.symmetric(
                          inside: BorderSide(color: Colors.grey),
                        ),
                        children: [
                          for (int row = 0; row <= contentTable2.length; row++)
                            if (row == 0)
                              TableRow(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(9),
                                    topRight: Radius.circular(9),
                                  ),
                                ),
                                children: [
                                  for (int col = 0;
                                      col < table2Labels.length;
                                      col++)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        table2Labels[col],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                ],
                              )
                            else
                              TableRow(
                                children: [
                                  for (int col = 0;
                                      col < table2Labels.length;
                                      col++)
                                    if (col == 0)
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '$row',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          contentTable2[row - 1]
                                              [table2Labels[col].toLowerCase()],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

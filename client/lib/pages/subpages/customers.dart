import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/constants/datas.dart';
import 'package:soul_connection/models/customer.module.dart';
import 'package:soul_connection/models/encounter.module.dart';
import 'package:soul_connection/models/payement.module.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/widgets/appbar.dart';
import 'package:soul_connection/pages/subpages/widgets/drop_down_button.dart';
import 'package:soul_connection/theme/color.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage>
    with HoverMixin<CustomersPage> {
  CustomerModel currentCustomer = filteredCustomers.isNotEmpty
      ? filteredCustomers.first
      : CustomerModel(
          userId: 1,
          email: '',
          name: '',
          surname: '',
          birthDate: '',
          gender: '',
          description: '',
          astrologicalSign: '',
          phoneNumber: '',
          address: '',
          clothes: [],
          profilePicture: '',
          payements: [],
          encouters: [],
        );

  String fillPaymentTable(PayementModel payment, int index) {
    if (index == 0) return payment.date;
    if (index == 1) return '${payment.amount}e';
    if (index == 2) return '${payment.paymentMethod}e';
    return '';
  }

  String fillEncouterTable(EncounterModel encounter, int index) {
    if (index == 0) return encounter.date;
    if (index == 1) return '${encounter.rating}/5';
    if (index == 2) return encounter.comment;
    if (index == 3) return encounter.source;
    return '';
  }

  Widget profilePic() {
    return Padding(
      padding: const EdgeInsets.only(right: 80),
      child: Builder(
        builder: (context) {
          return MouseRegion(
            onEnter: (event) {
              final renderBox = context.findRenderObject() as RenderBox;
              onHoverCard(event, 9, renderBox);
            },
            onHover: (event) {
              final renderBox = context.findRenderObject() as RenderBox;
              onHoverCard(event, 9, renderBox);
            },
            onExit: onExit,
            child: Transform(
              transform:
                  hoveredIndex == 9 ? getTransformMatrix() : Matrix4.identity(),
              alignment: FractionalOffset.center,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: hoveredIndex == 9 ? 160 : 140,
                height: hoveredIndex == 9 ? 160 : 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                ),
                child: CachedNetworkImage(
                  imageUrl: currentCustomer.profilePicture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (filteredCustomers.isEmpty) {
      return const Center(
        child: Text('No customers found'),
      );
    }
    return SizedBox(
      width: dw(context),
      height: dh(context),
      child: SingleChildScrollView(
        child: Column(
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
                    padding: const EdgeInsets.only(left: 30, right: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: !kIsWeb ? 335 : 350,
                            height: 30,
                            child: CustomerDropdown(
                              onCustomerChange:
                                  (CustomerModel currentCustomer) {
                                setState(() {
                                  this.currentCustomer = currentCustomer;
                                });
                              },
                            ),
                          ),
                          sh(20),
                          if (!kIsWeb)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: dw(context) - 100,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: Colors.black),
                                      Flexible(
                                        child: Text(
                                          '${currentCustomer.name} ${currentCustomer.surname}',
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Arial',
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CachedNetworkImage(
                                  height: 40,
                                  width: 40,
                                  imageUrl: currentCustomer.profilePicture,
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                const Icon(Icons.emoji_people,
                                    color: Colors.black),
                                Text(
                                  '${currentCustomer.name} ${currentCustomer.surname}',
                                  style: const TextStyle(
                                    fontSize: 40,
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
                                ' ${currentCustomer.birthDate}',
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial',
                                ),
                              ),
                            ],
                          ),
                          sh(5),
                          if (!kIsWeb)
                            SizedBox(
                              width: dw(context) - 60,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.location_on,
                                      color: Colors.black),
                                  Flexible(
                                    child: Text(
                                      ' ${currentCustomer.address}',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Arial',
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          else
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.black),
                                Flexible(
                                  child: Text(
                                    ' ${currentCustomer.address}',
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (kIsWeb) profilePic()
                ],
              ),
            ),
            sh(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                height: 1.5,
                color: Colors.black,
                width: dw(context),
              ),
            ),
            sh(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: kIsWeb
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (user!.work != 'Coach')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  'Payments',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Arial',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                width: dw(context) / 3.3,
                                height: 179,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black, width: 1.5),
                                ),
                                child: SingleChildScrollView(
                                  child: Table(
                                    border: const TableBorder.symmetric(
                                      inside: BorderSide(
                                          color: Colors.black, width: 1.5),
                                    ),
                                    children: [
                                      for (int row = 0;
                                          row <=
                                              currentCustomer.payements.length;
                                          row++)
                                        if (row == 0)
                                          TableRow(
                                            decoration: const BoxDecoration(
                                              color: AppColor.deepblue,
                                            ),
                                            children: [
                                              for (int col = 0;
                                                  col < table1Labels.length;
                                                  col++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    table1Labels[col],
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
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
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    fillPaymentTable(
                                                        currentCustomer
                                                            .payements[row - 1],
                                                        col),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
                              padding: EdgeInsets.symmetric(
                                vertical: 3,
                              ),
                              child: Text(
                                'Meetings',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              width: dw(context) / 2.4,
                              height: 179,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                              ),
                              child: SingleChildScrollView(
                                child: Table(
                                  border: const TableBorder.symmetric(
                                    inside: BorderSide(
                                        color: Colors.black, width: 1.5),
                                  ),
                                  children: [
                                    for (int row = 0;
                                        row <= currentCustomer.encouters.length;
                                        row++)
                                      if (row == 0)
                                        TableRow(
                                          decoration: const BoxDecoration(
                                            color: AppColor.deepblue,
                                          ),
                                          children: [
                                            for (int col = 0;
                                                col < table2Labels.length;
                                                col++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  table2Labels[col],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    currentCustomer
                                                        .encouters[row - 1].date
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )
                                              else
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    fillEncouterTable(
                                                      currentCustomer
                                                          .encouters[row - 1],
                                                      col,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                'Payments',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              width: dw(context),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                              ),
                              child: SingleChildScrollView(
                                child: Table(
                                  border: const TableBorder.symmetric(
                                    inside: BorderSide(
                                        color: Colors.black, width: 1.5),
                                  ),
                                  children: [
                                    for (int row = 0;
                                        row <= currentCustomer.payements.length;
                                        row++)
                                      if (row == 0)
                                        TableRow(
                                          decoration: const BoxDecoration(
                                            color: AppColor.deepblue,
                                          ),
                                          children: [
                                            for (int col = 0;
                                                col < table1Labels.length;
                                                col++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  table1Labels[col],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  fillPaymentTable(
                                                      currentCustomer
                                                          .payements[row - 1],
                                                      col),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
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
                              padding: EdgeInsets.symmetric(
                                vertical: 3,
                              ),
                              child: Text(
                                'Meetings',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Arial',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              width: dw(context),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 1.5),
                              ),
                              child: SingleChildScrollView(
                                child: Table(
                                  border: const TableBorder.symmetric(
                                    inside: BorderSide(
                                        color: Colors.black, width: 1.5),
                                  ),
                                  children: [
                                    for (int row = 0;
                                        row <= currentCustomer.encouters.length;
                                        row++)
                                      if (row == 0)
                                        TableRow(
                                          decoration: const BoxDecoration(
                                            color: AppColor.deepblue,
                                          ),
                                          children: [
                                            for (int col = 0;
                                                col < table2Labels.length;
                                                col++)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  table2Labels[col],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    currentCustomer
                                                        .encouters[row - 1].date
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                )
                                              else
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    fillEncouterTable(
                                                      currentCustomer
                                                          .encouters[row - 1],
                                                      col,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
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
        ),
      ),
    );
  }
}

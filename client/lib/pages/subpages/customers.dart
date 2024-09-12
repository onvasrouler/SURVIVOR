import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/customer.module.dart';
import 'package:soul_connection/models/encounter.module.dart';
import 'package:soul_connection/models/payement.module.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';

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

  String getImage(String payment) {
    if (payment == 'PayPal') return 'assets/paypal.png';
    if (payment == 'Credit Card') return 'assets/creditcard.png';
    if (payment == 'Bank Transfer') return 'assets/bank1.png';
    return 'assets/mastercard.png';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        sh(10),
        SizedBox(
          width: dw(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Customers List',
                      style: TextStyle(
                        color: Color(0xff3b546d),
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  sh(3),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'You have total ${filteredCustomers.length} customers.',
                      style: const TextStyle(
                        color: Color(0xff708dab),
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: [
                    Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color(0xffeaeef6), width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          sw(5),
                          const Icon(
                            Icons.cloud_download_outlined,
                            color: Color(0xff415a7e),
                            size: 15,
                          ),
                          sw(2),
                          const Text(
                            'Export',
                            style: TextStyle(
                              color: Color(0xff415a7e),
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          sw(5),
                        ],
                      ),
                    ),
                    sw(15),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: const Color(0xff0065b9),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        sh(30),
        Container(
          width: dw(context),
          height: kIsWeb ? dh(context) / 1.3 : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: const Color(0xffeaeef6), width: 2),
          ),
          child: Column(
            children: [
              Container(
                height: 70,
                width: dw(context),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: const Color(0xffeaeef6), width: 2),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Bulk Action',
                                style: TextStyle(
                                  color: Color(0xff8fa4bd),
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                        sw(15),
                        Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xfffafafc),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: const Color(0xffeaeef6), width: 2),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                              color: Color(0xff9da9bd),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.search,
                          size: 20,
                          color: Color(0xff415a7e),
                        ),
                        sw(15),
                        Container(
                          height: 40,
                          width: 1,
                          color: const Color(0xffeaeef6),
                        ),
                        sw(15),
                        const Icon(
                          Icons.filter_list_sharp,
                          size: 17,
                          color: Color(0xff415a7e),
                        ),
                        sw(15),
                        const Icon(
                          Icons.settings,
                          size: 17,
                          color: Color(0xff415a7e),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 2,
                width: dw(context),
                color: const Color(0xffeaeef6),
              ),
              Container(
                height: 30,
                width: dw(context),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      activeColor: const Color(0xff0065b9),
                    ),
                    SizedBox(
                      height: 30,
                      width: dw(context) - 106,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Coach',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff9da9bd),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 230,
                            child: Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff9da9bd),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 140,
                            child: Text(
                              'Phone',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff9da9bd),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: Text(
                              'Number of customers',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff9da9bd),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'Actions',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff9da9bd),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: dw(context),
                height: dh(context) / 1.6,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredCustomers.length,
                  itemBuilder: (context, index) {
                    final customer = filteredCustomers[index];
                    return Column(
                      children: [
                        Container(
                          height: 2,
                          width: dw(context),
                          color: const Color(0xffeaeef6),
                        ),
                        Container(
                          height: 50,
                          width: dw(context),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                                activeColor: const Color(0xff0065b9),
                              ),
                              SizedBox(
                                height: 30,
                                width: dw(context) - 106,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Row(
                                        children: [
                                          sw(10),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    customer.profilePicture,
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  color: [
                                                    const Color(0xff748bff),
                                                    const Color(0xfffc403c),
                                                    const Color(0xff253384),
                                                    const Color(0xffffb05f),
                                                    const Color(0xff0064b9),
                                                  ][index % 5],
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    (customer.name.substring(
                                                                0, 1) +
                                                            customer.surname
                                                                .substring(
                                                                    0, 1))
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          sw(10),
                                          Text(
                                            '${customer.name} ${customer.surname}',
                                            style: const TextStyle(
                                              color: Color(0xff3b546d),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 230,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        customer.email,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff9da9bd),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        customer.phoneNumber,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff9da9bd),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Container(
                                      width: 170,
                                      alignment: Alignment.centerLeft,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: SizedBox(
                                          width: 70,
                                          height: 30,
                                          child: Image.asset(
                                            getImage(customer
                                                .payements.last.paymentMethod),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Icons.more_horiz),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

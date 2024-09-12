import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/pages/subpages/widgets/customers.graph.dart';
import 'package:soul_connection/pages/subpages/widgets/events.graph.dart';
import 'package:soul_connection/pages/subpages/widgets/map.graph.dart';
import 'package:soul_connection/pages/subpages/widgets/meeting.graph.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> countries = ['United States', 'United Kingdom', 'India'];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dh(context),
      width: dw(context),
      child: SingleChildScrollView(
        child: Column(
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
                          'Dashboard',
                          style: TextStyle(
                            color: Color(0xff3b546d),
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      sh(3),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome!',
                          style: TextStyle(
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
                          width: 150,
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
                                Icons.calendar_month_outlined,
                                color: Color(0xff415a7e),
                                size: 15,
                              ),
                              sw(5),
                              const Text(
                                'Last 30 Days',
                                style: TextStyle(
                                  color: Color(0xff415a7e),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              sw(5),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xff415a7e),
                                size: 10,
                              ),
                              sw(5),
                            ],
                          ),
                        ),
                        sw(15),
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xff0065b9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.analytics_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                              sw(5),
                              const Text(
                                'Reports',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
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
            sh(20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: dh(context) / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: const Color(0xffeaeef6), width: 2),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Customers Overview',
                                  style: TextStyle(
                                    color: Color(0xff3b546d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                sh(3),
                                const Text(
                                  'When customers have joined in the time.',
                                  style: TextStyle(
                                    color: Color(0xff8ca1ba),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: const Color(0xffeaeef6), width: 2),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(2),
                                  const Text(
                                    '7 D',
                                    style: TextStyle(
                                      color: Color(0xff869cb7),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 2,
                                        color: const Color(0xffeaeef6),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 35,
                                        color: const Color(0xffeaeef6),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          '1 M',
                                          style: TextStyle(
                                            color: Color(0xff869cb7),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: 2,
                                        color: const Color(0xffeaeef6),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '3 M',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xff869cb7),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  sw(2),
                                ],
                              ),
                            ),
                          ],
                        ),
                        sh(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Customers',
                                  style: TextStyle(
                                    color: Color(0xff8ca1ba),
                                    fontSize: 12,
                                  ),
                                ),
                                sh(5),
                                const Text(
                                  '2,500',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Color(0xfffc4648),
                                      size: 10,
                                    ),
                                    Text(
                                      '12.48%',
                                      style: TextStyle(
                                        color: Color(0xfffc4648),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Doing meetings',
                                  style: TextStyle(
                                    color: Color(0xff8ca1ba),
                                    fontSize: 12,
                                  ),
                                ),
                                sh(5),
                                const Text(
                                  '28.48%',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                sh(5),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Color(0xff26efc8),
                                      size: 10,
                                    ),
                                    Text(
                                      '12.48%',
                                      style: TextStyle(
                                        color: Color(0xff26efc8),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Customers by coach',
                                  style: TextStyle(
                                    color: Color(0xff8ca1ba),
                                    fontSize: 12,
                                  ),
                                ),
                                sh(5),
                                const Text(
                                  '34',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            sw(dw(context) / 5)
                          ],
                        ),
                        sh(40),
                        SizedBox(
                          width: dw(context) / 1,
                          height: dh(context) / 4.4,
                          child: const CustomersGraph(),
                        ),
                      ],
                    ),
                  ),
                ),
                sw(20),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: dh(context) / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border:
                          Border.all(color: const Color(0xffeaeef6), width: 2),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Events',
                                  style: TextStyle(
                                    color: Color(0xff3b546d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                sh(3),
                                const Text(
                                  'Our events and their status.',
                                  style: TextStyle(
                                    color: Color(0xff8ca1ba),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              CupertinoIcons.question_circle,
                              color: Color.fromARGB(255, 224, 224, 224),
                              size: 14,
                            ),
                          ],
                        ),
                        sh(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Monthly',
                                  style: TextStyle(
                                    color: Color(0xff8ca1ba),
                                    fontSize: 12,
                                  ),
                                ),
                                sh(5),
                                const Text(
                                  '83',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Color(0xfffc4648),
                                      size: 10,
                                    ),
                                    Text(
                                      '12.48%',
                                      style: TextStyle(
                                        color: Color(0xfffc4648),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Weekly',
                                  style: TextStyle(
                                    color: Color(0xff8ca1ba),
                                    fontSize: 12,
                                  ),
                                ),
                                sh(5),
                                const Text(
                                  '28.48%',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                sh(5),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_upward,
                                      color: Color(0xff26efc8),
                                      size: 10,
                                    ),
                                    Text(
                                      '12.48%',
                                      style: TextStyle(
                                        color: Color(0xff26efc8),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Daily (Avg)',
                                  style: TextStyle(
                                    color: Color(0xff8ca1ba),
                                    fontSize: 12,
                                  ),
                                ),
                                sh(5),
                                const Text(
                                  '34',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            sw(10)
                          ],
                        ),
                        sh(40),
                        SizedBox(
                          height: dh(context) / 4.4,
                          width: dw(context) / 1,
                          child: const EventGraph(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            sh(20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: dh(context) / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border:
                          Border.all(color: const Color(0xffeaeef6), width: 2),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Customers by Country',
                                  style: TextStyle(
                                    color: Color(0xff3b546d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 30,
                                width: 90,
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
                                      '30 Days',
                                      style: TextStyle(
                                        color: Color(0xff415a7e),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        sh(20),
                        SizedBox(
                          height: dh(context) / 5,
                          width: dw(context) / 1,
                          child: const SupportedCountriesMap(),
                        ),
                        sh(10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: countries.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: dw(context) / 4,
                                  child: Text(
                                    countries[index],
                                    style: const TextStyle(
                                      color: Color(0xff95a9c0),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    '1,500',
                                    style: TextStyle(
                                      color: Color(0xff3b546d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const Text(
                                  '29%',
                                  style: TextStyle(
                                    color: Color(0xff95a9c0),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                sw(20),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: dh(context) / 2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: const Color(0xffeaeef6), width: 2),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Meeting top sources',
                                  style: TextStyle(
                                    color: Color(0xff3b546d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: 30,
                                width: 90,
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
                                      '30 Days',
                                      style: TextStyle(
                                        color: Color(0xff415a7e),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        sh(20),
                        SizedBox(
                          height: dh(context) / 3,
                          width: dw(context) / 1,
                          child: const PieChartSample(),
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
    );
  }
}

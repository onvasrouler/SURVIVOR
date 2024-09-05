import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/constants/datas.dart';
import 'package:soul_connection/models/user.module.dart';
import 'package:soul_connection/pages/subpages/widgets/drop_down_button.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage({super.key, required this.user});
  final UserModel user;

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  int currentIndex = 0;
  Map<String, dynamic> currentCustomer = {
    'name': 'Louis Delanata',
    'id': 1,
    'birthday': '02/03/2006',
    'address': '3 Rue de al Tour 34000 Montpelier, France'
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dh(context),
      width: dw(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  sh(80),
                  for (int i = 0; i < 4; i++)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: dh(context) / 6.5,
                        width: dw(context) / 1,
                        child: CarouselSlider.builder(
                          itemCount: 10,
                          itemBuilder: (context, index, realIndex) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              width: dw(context) / 3,
                              height: dh(context) / 6,
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: FittedBox(
                                  child: Text(
                                    index.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            autoPlayInterval: const Duration(seconds: 4),
                            viewportFraction: 0.5,
                            initialPage: 0,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            enlargeFactor: 1,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged:
                                (int index, CarouselPageChangedReason reason) {
                              if (mounted) {
                                setState(() {
                                  currentIndex = index;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    )
                ],
              ),
              IgnorePointer(
                ignoring: true,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Container(
                      width: dh(context) - 220,
                      height: dw(context) / 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xfff2f2f2),
                            const Color(0xfff2f2f2),
                            const Color(0xfff2f2f2),
                            const Color(0xfff2f2f2),
                            const Color(0xfff2f2f2),
                            const Color(0xfff2f2f2),
                            const Color(0xfff2f2f2),
                            for (double i = 1; i > 0; i -= 0.1)
                              const Color(0xfff2f2f2).withOpacity(i)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: dh(context),
                    color: Colors.transparent,
                    width: 365,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sh(70),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 365,
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
                        sh(50),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(
                                  widget.user.profilePic!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        sh(20),
                        Container(
                          width: 120,
                          alignment: Alignment.center,
                          child: const Text(
                            'gender',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

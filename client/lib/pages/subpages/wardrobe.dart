import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/customer.module.dart';
import 'package:soul_connection/pages/subpages/widgets/drop_down_button.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage({super.key});

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage> {
  int currentIndex = 0;
  Customer currentCustomer = allCustomers.first;
  List<String> imageTypes = ['hat/cap', 'bottom', 'top', 'shoes'];

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  for (int i = 0; i < imageTypes.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        height: dh(context) / 2,
                        width: dw(context) / 7,
                        child: CarouselSlider.builder(
                          itemCount: currentCustomer.clothes
                              .where((c) => c['type'] == imageTypes[i])
                              .length,
                          itemBuilder: (context, index, realIndex) {
                            final currentClothes = currentCustomer.clothes
                                .where((c) => c['type'] == imageTypes[i])
                                .toList();
                            if (currentClothes.isEmpty) {
                              return const SizedBox();
                            }
                            final filterdClothes = currentClothes[index];
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              width: dw(context) / 5,
                              height: dh(context) / 1,
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'http://localhost:8080/clothes/${currentCustomer.userId}_${filterdClothes['id']}.png',
                                  fit: BoxFit.contain,
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
                            scrollDirection: Axis.vertical,
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
                    ),
                  sw(100),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: dh(context),
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
                            onCustomerChange: (Customer currentCustomer) async {
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
                                  currentCustomer.profilePicture,
                                ),
                              ),
                            ),
                          ),
                        ),
                        sh(20),
                        Container(
                          width: 120,
                          alignment: Alignment.center,
                          child: Text(
                            currentCustomer.gender,
                            style: const TextStyle(
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/customer.module.dart';
import 'package:soul_connection/pages/subpages/interface/mouse_pointer.dart';
import 'package:soul_connection/pages/subpages/widgets/drop_down_button.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage({super.key});

  @override
  State<WardrobePage> createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage>
    with HoverMixin<WardrobePage> {
  int currentIndex = 0;
  Customer currentCustomer = allCustomers.first;
  List<String> imageTypes = ['hat/cap', 'top', 'bottom', 'shoes'];

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
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < imageTypes.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: dh(context) / 1.3,
                              width: dw(context) / 6,
                              child: CarouselSlider.builder(
                                itemCount: currentCustomer.clothes
                                    .where((c) => c['type'] == imageTypes[i])
                                    .length,
                                itemBuilder: (context, index, realIndex) {
                                  final currentClothes = currentCustomer.clothes
                                      .where((c) => c['type'] == imageTypes[i])
                                      .toList();
                                  if (currentClothes.isEmpty) {
                                    return AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                      width: dw(context) / 4,
                                      height: dh(context) / 1,
                                      padding: const EdgeInsets.all(10.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Container(
                                          width: dw(context) / 4,
                                          height: dh(context) / 1,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'No clothes found in this category',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  final filterdClothes = currentClothes[index];
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    width: dw(context) / 4,
                                    height: dh(context) / 1,
                                    padding: const EdgeInsets.all(10.0),
                                    child: SizedBox(
                                      width: dw(context) / 4,
                                      height: dh(context) / 1,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'http://82.65.59.34:3333/soul_connection_api/clothe_image/${filterdClothes['id']}.png?session=$token',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  autoPlayInterval: const Duration(seconds: 14),
                                  viewportFraction: 0.3,
                                  initialPage: 0,
                                  autoPlay: false,
                                  aspectRatio: 16 / 9,
                                  enlargeFactor: 0.6,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  scrollDirection: Axis.vertical,
                                  onPageChanged: (int index,
                                      CarouselPageChangedReason reason) {
                                    if (mounted) {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                            if (dw(context) >= 700)
                              Text(
                                imageTypes[i],
                                style: const TextStyle(
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
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
                          width: 320,
                          height: 30,
                          child: CustomerDropdown(
                            onCustomerChange: (Customer currentCustomer) async {
                              setState(() {
                                this.currentCustomer = currentCustomer;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: dh(context),
                    width: dw(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        sh(60),
                        Builder(
                          builder: (context) {
                            return MouseRegion(
                              onEnter: (event) {
                                final renderBox =
                                    context.findRenderObject() as RenderBox;
                                onHoverCard(event, 9, renderBox);
                              },
                              onHover: (event) {
                                final renderBox =
                                    context.findRenderObject() as RenderBox;
                                onHoverCard(event, 9, renderBox);
                              },
                              onExit: onExit,
                              child: Transform(
                                transform: hoveredIndex == 9
                                    ? getTransformMatrix()
                                    : Matrix4.identity(),
                                alignment: FractionalOffset.center,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: hoveredIndex == 9 ? 100 : 90,
                                  height: hoveredIndex == 9 ? 100 : 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 1.5),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: currentCustomer.profilePicture,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

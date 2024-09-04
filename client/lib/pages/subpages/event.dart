import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/subpages/widget/appbar.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appBar(context, 'Events'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: dw(context) / 2.7,
                  height: dh(context) / 1.4,
                  child: Image.network(
                    'https://www.google.com/maps/about/images/mymaps/mymaps-desktop-16x9.png',
                    fit: BoxFit.cover,
                    // 'https://maps.googleapis.com/maps/api/staticmap?center=0,0&zoom=17&size=400x500&key=AIzaSyCw6ctRtCVu_yXCD_WCTjX2mU2FCCk4gPw',
                  ),
                ),
              ),
              sw(30),
              SizedBox(
                height: dh(context) / 1.3,
                width: dw(context) / 4,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        height: dh(context) / 1.3,
                        width: dw(context) / 4,
                        child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 100,
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Speed Dating',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '22/04/2024',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on, color: Colors.red,),
                                          Text(
                                            'Café Michel',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Max participants :20',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: dw(context),
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: dw(context),
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xfff2f2f2),
                              for (double i = 1; i > 0; i -= 0.1)
                                const Color(0xfff2f2f2).withOpacity(i)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              sw(30),
            ],
          ),
        )
      ],
    );
  }
}

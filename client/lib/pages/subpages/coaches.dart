import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/constants/datas.dart';
import 'package:soul_connection/pages/subpages/widgets/appbar.dart';
import 'package:soul_connection/theme/color.dart';

class CoachesPage extends StatefulWidget {
  const CoachesPage({super.key});

  @override
  State<CoachesPage> createState() => _CoachesPageState();
}

class _CoachesPageState extends State<CoachesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appBar(context, 'Coaches'),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: dw(context) < 700 ? dw(context) / 1.2 : dw(context) / 1.55,
          height: dh(context) / 1.4,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.5),
          ),
          child: SingleChildScrollView(
            child: Table(
              border: const TableBorder.symmetric(
                inside: BorderSide(color: Colors.black, width: 1.5),
              ),
              children: [
                for (int row = 0; row <= users.length; row++)
                  if (row == 0)
                    TableRow(
                      decoration: const BoxDecoration(
                        color: AppColor.deepblue,
                      ),
                      children: [
                        for (int col = 0; col < tableCoaches.length; col++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tableCoaches[col],
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
                        for (int col = 0; col < tableCoaches.length; col++)
                          if (col == 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '$row',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )
                          else if (col == 3)
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: dw(context),
                                      height: dh(context),
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          sh(80),
                                          const Text(
                                            'Edit list',
                                            style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          sh(20),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Container(
                                              height: 1.5,
                                              color: Colors.black,
                                              width: dw(context),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 250,
                                            height: dh(context) - 150,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: allCustomers.length,
                                              itemBuilder: (context, index) {
                                                return Center(
                                                  child: Container(
                                                    width: 250,
                                                    height: 30,
                                                    color: Colors.transparent,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            '${allCustomers[index].name} ${allCustomers[index].surname}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                                        Checkbox(
                                                          value: true,
                                                          activeColor:
                                                              AppColor.deepblue,
                                                          onChanged:
                                                              (bool? value) {},
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  users[row - 1]
                                      [tableCoaches[col].toLowerCase()],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                users[row - 1][tableCoaches[col].toLowerCase()],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                      ],
                    ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

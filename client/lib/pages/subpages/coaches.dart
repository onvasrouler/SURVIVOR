import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';
import 'package:soul_connection/pages/subpages/widget/appbar.dart';

class CoachesPage extends StatefulWidget {
  const CoachesPage({super.key});

  @override
  State<CoachesPage> createState() => _CoachesPageState();
}

class _CoachesPageState extends State<CoachesPage> {
  List<String> tableLabels = [
    '#',
    'Name',
    'Birth date',
    'Customers',
    'Last connection'
  ];

  List<Map<String, dynamic>> users = [
    {
      'name': 'Jean Patrick',
      'birth date': '09-01-1987',
      'customers': 'Edit list',
      'last connection': '18-07-2024',
    },
    {
      'name': 'Patrick Michel',
      'birth date': '29-01-1943',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '12-01-1921',
      'customers': 'Edit list',
      'last connection': '15-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
    {
      'name': 'Jean Patrick',
      'birth date': '14-01-1999',
      'customers': 'Edit list',
      'last connection': '12-07-2024',
    },
  ];

  List<String> clients = [
    'Louis Bagneul',
    'Véronique Tanson',
    'Angele Labelge',
    'Nicolas Tarabavich'
  ];

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
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: SingleChildScrollView(
            child: Table(
              border: const TableBorder.symmetric(
                inside: BorderSide(color: Colors.grey),
              ),
              children: [
                for (int row = 0; row <= users.length; row++)
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
                        for (int col = 0; col < tableLabels.length; col++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              tableLabels[col],
                              textAlign: TextAlign.center,
                            ),
                          ),
                      ],
                    )
                  else
                    TableRow(
                      children: [
                        for (int col = 0; col < tableLabels.length; col++)
                          if (col == 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '$row',
                                textAlign: TextAlign.center,
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
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          sh(20),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Container(
                                              height: 1,
                                              color: Colors.grey,
                                              width: dw(context),
                                            ),
                                          ),
                                          sh(40),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: clients.length,
                                            itemBuilder: (context, index) {
                                              return Center(
                                                child: Container(
                                                  width: 250,
                                                  height: 30,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          clients[index],
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      Checkbox(
                                                        value: true,
                                                        activeColor:
                                                            Colors.blue,
                                                        onChanged:
                                                            (bool? value) {},
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
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
                                      [tableLabels[col].toLowerCase()],
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                users[row - 1][tableLabels[col].toLowerCase()],
                                textAlign: TextAlign.center,
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

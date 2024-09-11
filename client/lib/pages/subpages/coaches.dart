import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soul_connection/auth/signup.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/constants/datas.dart';
import 'package:soul_connection/models/employees.module.dart';
import 'package:soul_connection/pages/subpages/widgets/appbar.dart';
import 'package:soul_connection/pages/subpages/widgets/edit_users.dart';
import 'package:soul_connection/theme/color.dart';

class CoachesPage extends StatefulWidget {
  const CoachesPage({super.key});

  @override
  State<CoachesPage> createState() => _CoachesPageState();
}

class _CoachesPageState extends State<CoachesPage> {
  String fillTable(EmployeeModel employee, int index) {
    if (index == 1) return '${employee.name} ${employee.surname}';
    if (index == 2) return employee.birthDate;
    if (index == 3) {
      return user!.work != 'Coach' ? 'Edit list ...' : 'View list ...';
    }
    if (index == 4) return employee.lastSession;
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        appBar(context, 'Coaches'),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const SignUpPage(),
              ),
            ).then((_) {
              setState(() {});
            });
          },
          child: const Icon(
            Icons.add,
            size: 40,
            color: Colors.red,
          ),
        ),
        SizedBox(
          width: kIsWeb ? null : dw(context),
          height: dh(context) - 207,
          child: SingleChildScrollView(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: dw(context) < 700 ? dw(context) / 1.2 : dw(context) / 1.55,
              height: kIsWeb ? dh(context) / 1.4 : null,
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
                    for (int row = 0; row <= allCoaches.length; row++)
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
                                      builder: (context) => EditCustomers(
                                        employee: allCoaches[row - 1],
                                        permission: user!.work != 'Coach',
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      fillTable(allCoaches[row - 1], col),
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
                                    fillTable(allCoaches[row - 1], col),
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
            ),
          ),
        )
      ],
    );
  }
}

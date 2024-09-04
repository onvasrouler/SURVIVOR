import 'package:flutter/material.dart';
import 'package:soul_connection/pages/constants/constants.dart';

class CustomerDropdown extends StatefulWidget {
  const CustomerDropdown({
    super.key,
    required this.customers,
    required this.onCustomerChange,
  });

  final List<Map<String, dynamic>> customers;
  final Function(Map<String, dynamic>) onCustomerChange;

  @override
  CustomerDropdownState createState() => CustomerDropdownState();
}

class CustomerDropdownState extends State<CustomerDropdown> {
  String? selectedCustomer;

  @override
  void initState() {
    super.initState();
    selectedCustomer =
        widget.customers.isNotEmpty ? widget.customers[0]['name'] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Customer:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          sw(5),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCustomer,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              padding: const EdgeInsets.only(left: 5),
              focusColor: const Color(0xfff2f2f2),
              dropdownColor: Colors.white,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCustomer = newValue!;
                  widget.onCustomerChange(
                    widget.customers.firstWhere(
                      (Map<String, dynamic> customer) =>
                          customer['name'] == newValue,
                    ),
                  );
                });
              },
              items: widget.customers
                  .map(
                    (Map<String, dynamic> customer) =>
                        customer['name'] as String,
                  )
                  .toList()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 18)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

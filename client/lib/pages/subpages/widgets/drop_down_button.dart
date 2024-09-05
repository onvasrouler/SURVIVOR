import 'package:flutter/material.dart';
import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/customer.module.dart';

class CustomerDropdown extends StatefulWidget {
  const CustomerDropdown({
    super.key,
    required this.onCustomerChange,
  });

  final Function(Customer) onCustomerChange;

  @override
  CustomerDropdownState createState() => CustomerDropdownState();
}

class CustomerDropdownState extends State<CustomerDropdown> {
  late Customer selectedCustomer;

  @override
  void initState() {
    super.initState();
    selectedCustomer = allCustomers.first;
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
          const Text(
            'Customer:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          sw(5),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: '${selectedCustomer.name} ${selectedCustomer.surname}',
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
              onChanged: (String? value) {
                setState(() {
                  selectedCustomer = allCustomers.where((Customer customer) {
                    return '${customer.name} ${customer.surname}' == value;
                  }).first;
                  widget.onCustomerChange(selectedCustomer);
                });
              },
              items: allCustomers
                  .map((Customer customer) =>
                      '${customer.name} ${customer.surname}')
                  .toList()
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 18)),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

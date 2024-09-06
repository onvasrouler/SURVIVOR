import 'package:soul_connection/constants/constants.dart';
import 'package:soul_connection/models/encounter.module.dart';
import 'package:soul_connection/models/payement.module.dart';

class Customer {
  final int userId;
  final String email;
  final String name;
  final String surname;
  final String birthDate;
  final String gender;
  final String description;
  final String astrologicalSign;
  final String phoneNumber;
  final String address;
  final String profilePicture;
  final List<Map<String, dynamic>> clothes;
  final List<Payement> payements;
  final List<Encounter> encouters;

  Customer({
    required this.userId,
    required this.email,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.gender,
    required this.description,
    required this.astrologicalSign,
    required this.phoneNumber,
    required this.address,
    required this.clothes,
    required this.profilePicture,
    required this.payements,
    required this.encouters,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      userId: json['id'],
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      description: json['description'],
      astrologicalSign: json['astrological_sign'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      clothes: (json['clothes'] as List)
          .map<Map<String, dynamic>>((e) => e)
          .toList(),
      profilePicture:
          'http://82.65.59.34:3333/soul_connection_api/customer_image/${json['id']}.png?session=$token',
      payements: (json['payments_history'] as List)
          .map<Payement>((e) => Payement.fromJson(e))
          .toList(),
      encouters: (json['encounters'] as List)
          .map<Encounter>((e) => Encounter.fromJson(e))
          .toList(),
    );
  }
}

import 'dart:convert';
import 'dart:typed_data';


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
  final Uint8List profilePicture;
  final List<Map<String, dynamic>> clothes;

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
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      userId: json['user_id'],
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      description: json['description'],
      astrologicalSign: json['astrological_sign'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      clothes: (json['clothes'] as List).map<Map<String, dynamic>>((e) => e).toList(),
      profilePicture: base64Decode(json['image']),
    );
  }
}

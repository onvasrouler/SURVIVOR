class Encounter {
  final int id;
  final int customerId;
  final int rating;
  final String date;

  Encounter({
    required this.id,
    required this.rating,
    required this.customerId,
    required this.date,
  });

  factory Encounter.fromJson(Map<String, dynamic> json) {
    return Encounter(
      id: json['id'],
      customerId: json['customer_id'],
      date: json['date'],
      rating: json['rating'],
    );
  }
}

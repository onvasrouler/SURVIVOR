class Payement {
  final int payementId;
  final double amount;
  final String date;
  final String paymentMethod;
  final String comment;

  Payement({
    required this.payementId,
    required this.date,
    required this.paymentMethod,
    required this.amount,
    required this.comment,
  });

  factory Payement.fromJson(Map<String, dynamic> json) {
    return Payement(
      payementId: json['id'],
      date: json['date'],
      paymentMethod: json['payment_method'],
      amount: json['amount'],
      comment: json['comment'],
    );
  }
}

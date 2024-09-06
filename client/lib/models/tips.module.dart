class Tips {
  final String title;
  final String tips;

  Tips({
    required this.title,
    required this.tips,
  });

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(
      title: json['title'],
      tips: json['tip'],
    );
  }
}

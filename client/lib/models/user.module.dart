class UserModel {
  String username;
  String email;
  String role;
  String creationIp;
  String lastConnection;
  String uniqueId;

  UserModel({
    required this.username,
    required this.email,
    required this.role,
    required this.creationIp,
    required this.lastConnection,
    required this.uniqueId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      role: json['role'],
      creationIp: json['creationIp'],
      lastConnection: json['lastConnection'],
      uniqueId: json['unique_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'role': role,
      'creationIp': creationIp,
      'lastConnection': lastConnection,
      'uniqueId': uniqueId,
    };
  }
}

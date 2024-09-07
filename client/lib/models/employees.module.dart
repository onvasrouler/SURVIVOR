class EmployeeModel {
  int id;
  String email;
  String name;
  String surname;
  String birthDate;
  String gender;
  String work;
  String lastSession;
  String employeeId;

  EmployeeModel({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.gender,
    required this.work,
    required this.lastSession,
    required this.employeeId,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      surname: json['surname'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      work: json['work'],
      employeeId: json['employee_id'],
      lastSession: json['lastConnection'] ?? 'Never',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'birth_date': birthDate,
      'gender': gender,
      'work': work,
      'employee_id': employeeId,
      'lastConnection': lastSession,
    };
  }
}

class RegisterAdminParams {
  const RegisterAdminParams({
    required this.userName,
    required this.password,
    required this.name,
    required this.email,
    this.phone1,
    this.phone2,
  });

  final String userName;
  final String password;
  final String name;
  final String email;
  final String? phone1;
  final String? phone2;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'userName': userName,
    'password': password,
    'name': name,
    'email': email,
    'phone1': phone1,
    'phone2': phone2,
  };
}

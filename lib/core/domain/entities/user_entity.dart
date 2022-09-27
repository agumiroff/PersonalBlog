class UserData {
  final String email;
  final String password;
  final String fullname;

  UserData({required this.email, required this.password, required this.fullname});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'fullname': fullname,
    };
  }
}

class SignUpBody {
  String name;
  String phone;
  String email;
  String password;

  SignUpBody(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() => {
        'f_name': name,
        'phone': phone,
        'email': email,
        'password': password,
      };
}

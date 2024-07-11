class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String token;
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.token,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        token: json['token'],
        gender: json['gender']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'token': token,
      'gender': gender,
    };
  }
}

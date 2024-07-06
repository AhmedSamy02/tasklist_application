import 'package:mongo_dart/mongo_dart.dart';

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.password,
  });
  factory User.fromMap(Map<String, dynamic> data) {
    final id = data['_id'] as ObjectId;
    return User(
      id: id.oid,
      firstName: data['first_name'] as String,
      lastName: data['last_name'] as String,
      gender: data['gender'] as String,
      email: data['email'] as String,
      password: data['password'] as String,
    );
  }
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String password;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
    };
  }

  Map<String, dynamic> toJsonWitoutPassword() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
    };
  }

  Map<String, dynamic> toJsonWithToken(String token) {
    return {
      'id': id,
      'token': token,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
    };
  }
}

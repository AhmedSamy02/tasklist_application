import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/models/user.dart';

class Authenticator {
  Future<User?> findUserByEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCollection = getIt.get<DbCollection>(instanceName: 'users');
    return  userCollection
        .findOne(where.eq('email', email).eq('password', password))
        .then((value) => value != null ? User.fromMap(value) : null);
  }
}

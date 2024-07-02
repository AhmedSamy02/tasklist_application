import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../constants/methods.dart';
import '../../constants/responses.dart';
import '../../constants/values.dart';
import '../../models/user.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  if (!checkMethod(context, HttpMethod.get)) {
    return Responses.methodNotAllowed;
  }
  final data = await getIt
      .get<DbCollection>(instanceName: 'users')
      .findOne(where.id(ObjectId.fromHexString(id)));
  if (data == null) {
    return Responses.notFound;
  }
  final user = User.fromMap(data);
  return successResponse('User Found Successfully', user.toJsonWitoutPassword());
}

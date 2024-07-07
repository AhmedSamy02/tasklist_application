import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/models/user.dart';


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

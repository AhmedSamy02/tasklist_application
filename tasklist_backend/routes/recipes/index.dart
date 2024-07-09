import 'dart:math';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/constants/values.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Responses.methodNotAllowed;
  }
  var pageLimit = context.request.url.queryParameters['limit'] == null
      ? 10
      : int.parse(context.request.url.queryParameters['limit']!);
  pageLimit = max(5, min(20, pageLimit));
  final pageNumber = context.request.url.queryParameters['offset'] == null
      ? 0
      : int.parse(context.request.url.queryParameters['offset']!);
  final data = await getIt
      .get<DbCollection>(instanceName: 'recipes')
      .find(where.skip(pageLimit * abs(pageNumber)).limit(pageLimit))
      .toList();
  for (final element in data) {
    final id = element['_id'] as ObjectId;
    element['_id'] = id.oid;
  }
  return successResponseWithPage(
    'Recipes Got Successfully',
    data,
    pageNumber,
    pageLimit,
  );
}

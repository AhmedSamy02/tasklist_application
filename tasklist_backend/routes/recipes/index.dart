import 'dart:math';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/constants/values.dart';
import 'package:tasklist_backend/repositories/recipes_repository.dart';

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
  final data = await context
      .read<RecipesRepository>()
      .getRecipies(pageNumber, pageLimit);
  return successResponseWithPage(
    'Recipes Got Successfully',
    data,
    pageNumber,
    pageLimit,
  );
}

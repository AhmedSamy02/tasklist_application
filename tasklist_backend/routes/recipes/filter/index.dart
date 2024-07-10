import 'dart:math';

import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/repositories/recipes_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  if (request.method != HttpMethod.post) {
    return Responses.methodNotAllowed;
  }

  final body = checkBody(await request.json());
  if (body == null) {
    return Responses.bodyNotProvided;
  }
  if (!body.containsKey('cuisine') ||
      body['cuisine'] is! String? ||
      !body.containsKey('course') ||
      body['course'] is! String? ||
      !body.containsKey('diet') ||
      body['diet'] is! String? ||
      !body.containsKey('prep_time') ||
      body['prep_time'] is! int? ||
      !body.containsKey('cook_time') ||
      body['cook_time'] is! int? ||
      !body.containsKey('offset') ||
      body['offset'] is! int? ||
      !body.containsKey('limit') ||
      body['limit'] is! int?) {
    return Responses.bodyNotProvided;
  }
  
  final recipies = await context.read<RecipesRepository>().filterRecipies(
        cuisine: body['cuisine'] as String?,
        course: body['course'] as String?,
        diet: body['diet'] as String?,
        prepTime: body['prep_time'] as int?,
        cookTime: body['cook_time'] as int?,
        page: body['offset'] as int?,
        limit: body['limit'] as int?,
      );
  return succesResponseWithList('Recipes Got Successfully', recipies);
}
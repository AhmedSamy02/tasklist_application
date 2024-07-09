import 'package:dart_frog/dart_frog.dart';
import 'package:tasklist_backend/constants/methods.dart';
import 'package:tasklist_backend/constants/responses.dart';
import 'package:tasklist_backend/repositories/recipes_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  if (!checkMethod(context, HttpMethod.get)) {
    return Responses.methodNotAllowed;
  }
  return successResponse(
    'Filters Got Successfully',
    await context.read<RecipesRepository>().getFilters(),
  );
}

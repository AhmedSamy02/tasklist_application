// ignore_for_file: no_default_cases

import 'package:dart_frog/dart_frog.dart';

import '../../lib/constants/responses.dart';

Response onRequest(RequestContext context) {
  // switch (context.request.method) {
  //   case HttpMethod.get:
  //   final usr
  //     break;
  //   case HttpMethod.post:

  //   default:
  //     return Responses.methodNotAllowed;
  // }
  return Responses.notFound;
}

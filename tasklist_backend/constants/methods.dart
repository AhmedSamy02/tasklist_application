import 'package:dart_frog/dart_frog.dart';

bool checkMethod(RequestContext context, HttpMethod method) {
  if (context.request.method != method) {
    return false;
  }
  return true;
}

Response successResponse(String message, Map<String, dynamic> data) {
  return Response.json(
    body: {
      'status_code': 200,
      'message': message,
      'data': data,
    },
  );
}

Response successResponseWithPage(
  String message,
  List<Map<String, dynamic>> data,
  int page,
  int limit,
) {
  return Response.json(
    body: {
      'status_code': 200,
      'message': message,
      'data': data,
      'pagination': {
        'page_number': page,
        'page_limit': limit,
      },
    },
  );
}
int abs(int number) {
  return number < 0 ? -number : number;
}

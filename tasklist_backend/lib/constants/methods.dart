import 'package:dart_frog/dart_frog.dart';

bool checkMethod(RequestContext context, HttpMethod method) {
  if (context.request.method != method) {
    return false;
  }
  return true;
}

bool checkSignupDataProvided(Map<String, dynamic> body) {
  if (body.containsKey('email') ||
      body.containsKey('password') ||
      body.containsKey('first_name') ||
      body.containsKey('last_name') ||
      body.containsKey('gender') ||
      body['email'] == null ||
      body['email'] == '' ||
      body['password'] == null ||
      body['password'] == '' ||
      body['first_name'] == null ||
      body['first_name'] == '' ||
      body['last_name'] == null ||
      body['last_name'] == '' ||
      body['gender'] == null ||
      body['gender'] == '') {
    return false;
  }
  return true;
}

bool checkEmailAcceptance(String email) {
  if (RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
      .hasMatch(email)) {
    return true;
  }
  return false;
}

bool checkKeyFoundOrEmpty(Map<String, dynamic> body, String key) {
  if (!body.containsKey(key) || body[key] == null || body[key] == '') {
    return false;
  }
  return true;
}

//* The pattern ensures that the password
//* 1) Contains at least 8 characters long
//* 2) Contains at least one digit
//* 3) Contains at least one uppercase letter
//* 4) Contains at least one lowercase letter
//* 5) Contains at least one special character
bool checkPasswordAcceptance(String password) {
  if (RegExp(
          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
      .hasMatch(password)) {
    return true;
  }
  return false;
}

bool checkGender(String gender) {
  if (gender.toLowerCase() == 'male' || gender.toLowerCase() == 'female') {
    return true;
  }
  return false;
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
Response succesResponseWithList(String message, List<Map<String, dynamic>> data) {
  return Response.json(
    body: {
      'status_code': 200,
      'message': message,
      'data': data,
    },
  );
}

Response badRequestResponse(String message) {
  return Response.json(
    body: {
      'status_code': 400,
      'message': message,
    },
    statusCode: 400,
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

Map<String,dynamic>? checkBody(dynamic body) {
  if (body == null || body is! Map<String, dynamic>) {
    return null;
  }
  return body;
}

int abs(int number) {
  return number < 0 ? -number : number;
}

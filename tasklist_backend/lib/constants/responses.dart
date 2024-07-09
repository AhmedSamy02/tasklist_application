import 'package:dart_frog/dart_frog.dart';

class Responses {
  static Response queryParameterNotProvided = Response.json(
    body: {
      'status_code': 400,
      'message': 'Required Query parameters not provided',
    },
    statusCode: 400,
  );
  static Response bodyNotProvided = Response.json(
    body: {
      'status_code': 400,
      'message': 'Required body not provided',
    },
    statusCode: 400,
  );
  static Response methodNotAllowed = Response.json(
    body: {'status_code': 405, 'message': 'Method not allowed'},
    statusCode: 405,
  );
  static Response notFound = Response.json(
    body: {'status_code': 404, 'message': 'Not found'},
    statusCode: 404,
  );
  static Response internalServerError = Response.json(
    body: {'status_code': 500, 'message': 'Internal server error'},
    statusCode: 500,
  );
  static Response badRequest = Response.json(
    body: {'status_code': 400, 'message': 'Bad request'},
    statusCode: 400,
  );
  static Response unauthorized = Response.json(
    body: {'status_code': 401, 'message': 'User is Unauthorized'},
    statusCode: 401,
  );
  static Response forbidden = Response.json(
    body: {'status_code': 403, 'message': 'Forbidden'},
    statusCode: 403,
  );
  static Response created = Response.json(
    body: {'status_code': 201, 'message': 'Created'},
    statusCode: 201,
  );
  static Response noContent = Response.json(
    body: {'status_code': 204, 'message': 'No content'},
    statusCode: 204,
  );
  static Response conflict = Response.json(
    body: {'status_code': 409, 'message': 'Conflict'},
    statusCode: 409,
  );
  static Response gone = Response.json(
    body: {'status_code': 410, 'message': 'Gone'},
    statusCode: 410,
  );
  static Response unsupportedMediaType = Response.json(
    body: {'status_code': 415, 'message': 'Unsupported media type'},
    statusCode: 415,
  );
  static Response unprocessableEntity = Response.json(
    body: {'status_code': 422, 'message': 'Unprocessable entity'},
    statusCode: 422,
  );
  static Response tooManyRequests = Response.json(
    body: {'status_code': 429, 'message': 'Too many requests'},
    statusCode: 429,
  );
  static Response serviceUnavailable = Response.json(
    body: {'status_code': 503, 'message': 'Service unavailable'},
    statusCode: 503,
  );
  static Response gatewayTimeout = Response.json(
    body: {'status_code': 504, 'message': 'Gateway timeout'},
    statusCode: 504,
  );
  static Response notImplemented = Response.json(
    body: {'status_code': 501, 'message': 'Not implemented'},
    statusCode: 501,
  );
  static Response notAcceptable = Response.json(
    body: {'status_code': 406, 'message': 'Not acceptable'},
    statusCode: 406,
  );
  static Response lengthRequired = Response.json(
    body: {'status_code': 411, 'message': 'Length required'},
    statusCode: 411,
  );
  static Response preconditionFailed = Response.json(
    body: {'status_code': 412, 'message': 'Precondition failed'},
    statusCode: 412,
  );
  static Response requestEntityTooLarge = Response.json(
    body: {'status_code': 413, 'message': 'Request entity too large'},
    statusCode: 413,
  );
  static Response requestUriTooLong = Response.json(
    body: {'status_code': 414, 'message': 'Request URI too long'},
    statusCode: 414,
  );
  static Response requestTimeout = Response.json(
    body: {'status_code': 408, 'message': 'Request timeout'},
    statusCode: 408,
  );
  static Response uriTooLong = Response.json(
    body: {'status_code': 414, 'message': 'URI too long'},
    statusCode: 414,
  );
}

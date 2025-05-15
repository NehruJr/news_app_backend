import 'package:dart_frog/dart_frog.dart';
import 'jwt_service.dart';

Middleware checkAuth() {
  return (handler) {
    return (context) async {
      final authHeader = context.request.headers['Authorization'];

      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response(statusCode: 401, body: 'Missing or invalid token');
      }

      final token = authHeader.substring(7);
      final jwt = verifyJwt(token);

      if (jwt == null) {
        return Response(statusCode: 401, body: 'Invalid or expired token');
      }

      final updatedContext = context.provide(() => jwt.payload);
      return handler(updatedContext);
    };
  };
}

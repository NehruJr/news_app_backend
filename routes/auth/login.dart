import 'package:bcrypt/bcrypt.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:news/auth/jwt_service.dart';
import 'package:news/db/mongo.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = await MongoDB.getInstance();
  final body = await context.request.json();
  final email = body['email'];
  final password = body['password'] as String;

  final user = await db.collection('users').findOne({'email': email});
  final storedHashed = user?['password'] as String;

  bool isPasswordCottect = BCrypt.checkpw(password, storedHashed);

  if (user == null || !isPasswordCottect) {
    return Response(statusCode: 401, body: 'Invalid credentials');
  }

  final token = createJwt({'email': email});
  return Response.json(body: {'token': token});
}

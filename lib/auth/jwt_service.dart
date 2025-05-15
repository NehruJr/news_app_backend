import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dotenv/dotenv.dart';

final env = DotEnv()..load();
var _secret = env['JWTSecretKey']!;

String createJwt(Map<String, dynamic> payload) {
  final jwt = JWT(payload, issuer: 'dart_frog');
  return jwt.sign(SecretKey(_secret), expiresIn: Duration(days: 7));
}

JWT? verifyJwt(String token) {
  try {
    return JWT.verify(token, SecretKey(_secret));
  } catch (_) {
    return null;
  }
}

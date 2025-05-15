import 'package:bcrypt/bcrypt.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:news/db/mongo.dart';

Future<void> onRequest(RequestContext context) async {
  final db = await MongoDB.getInstance();
  final collection = db.collection('users');

  final body = await context.request.json();
  final email = body['email'];
  final password = body['password'] as String;

  final existing = await collection.findOne(where.eq('email', email));
  if (existing != null) {
    throw Exception('Email already taken');
  }

  final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

  await collection.insertOne({
    'email': email,
    'password': hashedPassword,
    'createdAt': DateTime.now().toUtc(),
  });
}

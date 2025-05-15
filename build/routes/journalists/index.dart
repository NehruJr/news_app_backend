import 'package:dart_frog/dart_frog.dart';
import 'package:khamsa_ta3leem/db/mongo.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = await MongoDB.getInstance();
  final journalists = db.collection('journalists');

  if (context.request.method == HttpMethod.get) {
    final all = await journalists.find().toList();
    return Response.json(body: all);
  }

  if (context.request.method == HttpMethod.post) {
    final body = await context.request.json();
    final result = await journalists.insertOne({
      'name': body['name'],
      'email': body['email'],
      'bio': body['bio'],
    });
    return Response.json(body: {'insertedId': result.id.toHexString()});
  }

  return Response(statusCode: 405);
}

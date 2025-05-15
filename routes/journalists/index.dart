import 'package:dart_frog/dart_frog.dart';
import 'package:news/db/mongo.dart';

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
         'profilePic': body['profilePic'],
    });
    return Response.json(body: {'insertedId': result.id.toHexString()});
  }

  return Response(statusCode: 405);
}

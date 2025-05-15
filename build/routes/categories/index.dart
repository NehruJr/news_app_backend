import 'package:dart_frog/dart_frog.dart';
import 'package:khamsa_ta3leem/db/mongo.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = await MongoDB.getInstance();
  final collection = db.collection('categories');

  if (context.request.method == HttpMethod.get) {
    final categories = await collection.find().toList();
    return Response.json(body: categories);
  }

  if (context.request.method == HttpMethod.post) {
    final body = await context.request.json();
    final result = await collection.insertOne({
      'name': body['name'],
      'description': body['description'],
    });
    return Response.json(body: {'insertedId': result.id.toHexString()});
  }

  return Response(statusCode: 405);
}

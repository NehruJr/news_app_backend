import 'package:dart_frog/dart_frog.dart';
import 'package:news/db/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = await MongoDB.getInstance();
  final subcategoris = db.collection('subcategories');

  if (context.request.method == HttpMethod.get) {
    final all = await subcategoris.find().toList();
    return Response.json(body: all);
  }

  if (context.request.method == HttpMethod.post) {
    final body = await context.request.json();
    final result = await subcategoris.insertOne({
      'name': body['name'],
      'description': body['description'],
      'category_id': ObjectId.parse(body['category_id'] as String),
    });
    return Response.json(body: {'insertedId': result.id.toHexString()});
  }

  return Response(statusCode: 405);
}

import 'package:dart_frog/dart_frog.dart';
import 'package:khamsa_ta3leem/db/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<Response> onRequest(RequestContext context) async {
  final db = await MongoDB.getInstance();
  final articles = db.collection('articles');

  if (context.request.method == HttpMethod.get) {
    final all = await articles.find().toList();
    return Response.json(body: all);
  }

  if (context.request.method == HttpMethod.post) {
    final body = await context.request.json();
    final result = await articles.insertOne({
      'title': body['title'],
      'content': body['content'],
      'category_id': ObjectId.parse(body['category_id'] as String),
      'journalist_id': ObjectId.parse(body['journalist_id'] as String),
      'created_at': DateTime.now().toUtc().toIso8601String(),
    });
    return Response.json(body: {'insertedId': result.id.toHexString()});
  }

  return Response(statusCode: 405);
}

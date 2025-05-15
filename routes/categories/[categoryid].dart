import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:news/db/mongo.dart';

Future<Response> onRequest(RequestContext context, String categoryid) async {
  final db = await MongoDB.getInstance();
  final collection = db.collection('categories');

  if (context.request.method == HttpMethod.get) {
    print("categoryid $categoryid");
    final categories =
        await collection.findOne(where.id(ObjectId.parse(categoryid)));
    return Response.json(body: "$categories -- id: $categoryid");
  }

  return Response(statusCode: 405);
}

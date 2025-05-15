import 'package:dart_frog/dart_frog.dart';
import 'package:news/db/mongo.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(_mongoProvider());
}

Middleware _mongoProvider() {
  return (handler) {
    return (context) async {
      await MongoDB.getInstance();
      return handler(context);
    };
  };
}


import 'package:dart_frog/dart_frog.dart';
import 'package:khamsa_ta3leem/db/mongo.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(_mongoProvider());
}

Middleware _mongoProvider() {
  return (handler) {
    return (context) async {
      // Initialize MongoDB once when server starts
      await MongoDB.getInstance();
      return handler(context);
    };
  };
}

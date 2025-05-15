import 'package:dart_frog/dart_frog.dart';
import 'package:news/auth/auth_middleware.dart';

Handler middleware(Handler handler) => checkAuth()(handler);

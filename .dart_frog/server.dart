// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/subcategories/index.dart' as subcategories_index;
import '../routes/journalists/index.dart' as journalists_index;
import '../routes/categories/index.dart' as categories_index;
import '../routes/categories/[categoryid].dart' as categories_$categoryid;
import '../routes/auth/registerUser.dart' as auth_register_user;
import '../routes/auth/login.dart' as auth_login;
import '../routes/articles/index.dart' as articles_index;

import '../routes/categories/_middleware.dart' as categories_middleware;

void main() async {
  final address = InternetAddress.tryParse('') ?? InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  hotReload(() => createServer(address, port));
}

Future<HttpServer> createServer(InternetAddress address, int port) {
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/articles', (context) => buildArticlesHandler()(context))
    ..mount('/auth', (context) => buildAuthHandler()(context))
    ..mount('/categories', (context) => buildCategoriesHandler()(context))
    ..mount('/journalists', (context) => buildJournalistsHandler()(context))
    ..mount('/subcategories', (context) => buildSubcategoriesHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildArticlesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => articles_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildAuthHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/registerUser', (context) => auth_register_user.onRequest(context,))..all('/login', (context) => auth_login.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildCategoriesHandler() {
  final pipeline = const Pipeline().addMiddleware(categories_middleware.middleware);
  final router = Router()
    ..all('/', (context) => categories_index.onRequest(context,))..all('/<categoryid>', (context,categoryid,) => categories_$categoryid.onRequest(context,categoryid,));
  return pipeline.addHandler(router);
}

Handler buildJournalistsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => journalists_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildSubcategoriesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => subcategories_index.onRequest(context,));
  return pipeline.addHandler(router);
}


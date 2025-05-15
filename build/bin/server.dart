// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/subcategories/index.dart' as subcategories_index;
import '../routes/subcategories/[id].dart' as subcategories_$id;
import '../routes/journalists/index.dart' as journalists_index;
import '../routes/journalists/[id].dart' as journalists_$id;
import '../routes/categories/index.dart' as categories_index;
import '../routes/categories/[id].dart' as categories_$id;
import '../routes/articles/index.dart' as articles_index;
import '../routes/articles/[id].dart' as articles_$id;


void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..mount('/articles', (context) => buildArticlesHandler()(context))
    ..mount('/categories', (context) => buildCategoriesHandler()(context))
    ..mount('/journalists', (context) => buildJournalistsHandler()(context))
    ..mount('/subcategories', (context) => buildSubcategoriesHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildArticlesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => articles_index.onRequest(context,))..all('/<id>', (context,id,) => articles_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildCategoriesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => categories_index.onRequest(context,))..all('/<id>', (context,id,) => categories_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildJournalistsHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => journalists_index.onRequest(context,))..all('/<id>', (context,id,) => journalists_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

Handler buildSubcategoriesHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => subcategories_index.onRequest(context,))..all('/<id>', (context,id,) => subcategories_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}


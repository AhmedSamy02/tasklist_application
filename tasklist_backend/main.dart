import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

import 'lib/constants/values.dart';

Future<void> init(InternetAddress ip, int port) async {
  // Any code initialized within this method will only run on server start, any hot reloads
  // afterwards will not trigger this method until a hot restart.
  final db = Db('mongodb://localhost:27017/dart_frog');
  await db.open();
  getIt.registerSingleton<Db>(db);
  logger.i('Connected to database');
  getIt.registerSingleton<DbCollection>(
    db.collection('users'),
    instanceName: 'users',
  );
  logger.i('Registered users collection');
  getIt.registerSingleton<DbCollection>(
    db.collection('recipes'),
    instanceName: 'recipes',
  );
  logger.i('Registered recipes collection');
  getIt.registerSingleton<DbCollection>(
    db.collection('lists'),
    instanceName: 'lists',
  );
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  // 1. Execute any custom code prior to starting the server...

  // 2. Use the provided `handler`, `ip`, and `port` to create a custom `HttpServer`.
  // Or use the Dart Frog serve method to do that for you.
  return serve(handler, ip, port);
}

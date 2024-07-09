import 'dart:io';

import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
import 'package:cloudinary_api/uploader/uploader.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:dart_frog/dart_frog.dart';
import 'package:dio/dio.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tasklist_backend/constants/config.dart';
import 'package:tasklist_backend/constants/values.dart';

Future<void> init(InternetAddress ip, int port) async {
  // Any code initialized within this method will only run on server start, any hot reloads
  // afterwards will not trigger this method until a hot restart.
  final cloudinary = Cloudinary.fromStringUrl(kCloudinaryUrl);
  cloudinary.config.urlConfig.secure = true;
  final uploader = cloudinary.uploader();
  getIt.registerSingleton<Uploader>(uploader);
  logger.i('Connected to Cloudinary');
  getIt.registerSingleton<Dio>(Dio());
  final db = Db(kDbLink);
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
    db.collection('task_lists'),
    instanceName: 'task_lists',
  );
  logger.i('Registered task_lists collection');
  getIt.registerSingleton<DbCollection>(
    db.collection('tasks'),
    instanceName: 'tasks',
  );
  logger.i('Registered tasks collection');
  getIt.registerSingleton<DbCollection>(
    db.collection('media'),
    instanceName: 'media',
  );
  logger.i('Registered media collection');
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  // 1. Execute any custom code prior to starting the server...
  // 2. Use the provided `handler`, `ip`, and `port` to create a custom `HttpServer`.
  // Or use the Dart Frog serve method to do that for you.
  return serve(handler, ip, port);
}

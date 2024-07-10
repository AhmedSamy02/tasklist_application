import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getit = GetIt.instance;
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    colors: true,
    printEmojis: true,
    printTime: false,
  ),
);
const baseURL = 'http://localhost:8080/';

import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

GetIt getIt = GetIt.instance;
Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
  ),
);
const String secretKey = 'secret_key';
const String kDbLink = 'mongodb://localhost:27017/dart_frog';

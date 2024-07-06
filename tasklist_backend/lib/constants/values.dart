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

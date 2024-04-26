import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger.g.dart';

@riverpod
Logger logger(LoggerRef ref) {
  final appLogger = AppLogger();
  return appLogger.logger;
}

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  factory AppLogger() => _instance;

  AppLogger._internal();

  Logger get logger => _logger;
}

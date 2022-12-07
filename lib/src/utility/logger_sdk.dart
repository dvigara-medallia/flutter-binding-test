import 'package:logger/logger.dart';

class LoggerSDK {
  LoggerSDK._internal();
  static final LoggerSDK _instance = LoggerSDK._internal();
  static LoggerSDK get instance => _instance;
  final bool enabled = true;
  final bool tracking = true;
  final bool sessionReplay = true;
  final bool frameTracking = true;
  final bool routeObserver = true;
  final bool autoMasking = true;
  final bool screenWidget = true;
  final bool maskWidget = true;

  Logger get trackingLogger => Logger(
        filter: ModuleLogFilter(enabled: enabled, moduleEnabled: tracking),
      );
  Logger get sessionReplayLogger => Logger(
        filter: ModuleLogFilter(enabled: enabled, moduleEnabled: sessionReplay),
      );
}

class ModuleLogFilter extends DevelopmentFilter {
  ModuleLogFilter({required this.enabled, required this.moduleEnabled});
  final bool enabled;
  final bool moduleEnabled;
  @override
  bool shouldLog(LogEvent event) {
    if (!super.shouldLog(event)) return false;
    if (!enabled) return false;
    if (!moduleEnabled) return false;
    return true;
  }
}

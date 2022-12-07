import 'package:decibel_sdk/src/features/frame_tracking.dart';
import 'package:logger/logger.dart';

class LoggerSDK {
  static final LoggerSDK _instance = LoggerSDK._internal();

  factory LoggerSDK.all({
    bool enabled = true,
    bool tracking = true,
    bool sessionReplay = true,
    bool frameTracking = true,
    bool routeObserver = true,
    bool autoMasking = true,
    bool screenWidget = true,
    bool maskWidget = true,
  }) {
    _instance.enabled = enabled;
    _instance.tracking = tracking;
    _instance.sessionReplay = sessionReplay;
    _instance.frameTracking = frameTracking;
    _instance.routeObserver = routeObserver;
    _instance.autoMasking = autoMasking;
    _instance.screenWidget = screenWidget;
    _instance.maskWidget = maskWidget;
    return _instance;
  }

  LoggerSDK._internal();

  bool enabled = false;
  bool tracking = false;
  bool sessionReplay = false;
  bool frameTracking = false;
  bool routeObserver = false;
  bool autoMasking = false;
  bool screenWidget = false;
  bool maskWidget = false;

  Logger get trackingLogger {
    final LoggerSDK instance = LoggerSDK._instance;
    return _plainLogger(instance.tracking);
  }

  Logger get sessionReplayLogger {
    final LoggerSDK instance = LoggerSDK._instance;
    return _plainLogger(instance.sessionReplay);
  }

  Logger get frameTrackingLogger {
    final LoggerSDK instance = LoggerSDK._instance;
    return _plainLogger(instance.frameTracking);
  }

  Logger get routeObserverLogger {
    final LoggerSDK instance = LoggerSDK._instance;
    return _plainLogger(instance.routeObserver);
  }

  Logger get autoMaskingLogger {
    final LoggerSDK instance = LoggerSDK._instance;
    return _plainLogger(instance.autoMasking);
  }

  Logger get screenWidgetLogger {
    final LoggerSDK instance = LoggerSDK._instance;
    return _plainLogger(instance.screenWidget);
  }

  Logger get maskWidgetLogger {
    final LoggerSDK instance = LoggerSDK._instance;
    return _plainLogger(instance.maskWidget);
  }

  Logger _plainLogger(bool moduleEnabled) {
    return Logger(
      filter: ModuleLogFilter(
        enabled: enabled,
        moduleEnabled: moduleEnabled,
      ),
    );
  }
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

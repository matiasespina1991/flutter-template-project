import '../../config.dart';
import 'notify_that_app_is_runing_in_debug_mode.dart';

logConfigurations() {
  if (Config.debugMode) {
    notifyThatAppIsRunningInDebugMode();
  }
}

import 'package:flutter/material.dart';
import '../../app_settings/app_general_settings.dart';
import '../../routes/app_routes.dart';
import 'navigation.dart';

class Navigate {
  static bool _isNavigating = false;

  static Future<void> to(
    BuildContext context,
    String directionRouteName, {
    SlideDirection direction = SlideDirection.right,
    NavigationType type = NavigationType.push,
  }) async {
    if (DebugConfig.forceDebugScreen) {
      String? currentRouteName = Routes.getCurrentRouteName(context);

      debugPrint(
          '[DebugConfig.forceDebugScreen is set to true. Locked screen is: <$currentRouteName>. Navigation to </$directionRouteName> suspended.]');
      return;
    }

    if (_isNavigating) return;
    _isNavigating = true;

    final routeConfig = Routes.routes[directionRouteName];

    if (routeConfig == null) {
      Navigator.of(context).pushNamed('/404');
      _isNavigating = false;
      return;
    }

    final route = pushRouteWithAnimation(routeConfig.builder(context),
        direction: direction);

    try {
      if (type == NavigationType.replacement) {
        debugPrint('Navigating with replacement to: $directionRouteName');
        Navigator.of(context).pushReplacement(route);
      } else {
        debugPrint('Navigating with push to: $directionRouteName');
        Navigator.of(context).push(route);
      }
      debugPrint('Navigation to $directionRouteName completed.');
    } catch (e) {
      debugPrint('Navigation error: $e');
    } finally {
      _isNavigating = false;
    }
  }

  static void back(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}

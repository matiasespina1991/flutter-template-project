import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers_all.dart';

class ErrorReportingService {
  static Future<void> reportError(
      dynamic error, dynamic stackTrace, WidgetRef ref) async {
    final userData = await _getUserData(ref);
    final deviceData = await _getDeviceData();
    final appInfo = await _getAppInfo();

    final errorReport = {
      'timestamp': DateTime.now().toIso8601String(),
      'error': error.toString(),
      'stackTrace': stackTrace.toString(),
      'userData': userData,
      'deviceData': deviceData,
      'appInfo': appInfo,
    };

    debugPrint("Error Report: $errorReport");

    // TODO: Send this data to your server or error tracking service.
  }

  static Future<Map<String, dynamic>> _getUserData(WidgetRef ref) async {
    final auth = ref.read(authProvider);
    return {
      'isAuthenticated': auth.isAuthenticated,
      'authToken': auth.authToken,
      // Add more user-specific data as needed.
    };
  }

  static Future<Map<String, dynamic>> _getDeviceData() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return {
        'model': androidInfo.model,
        'manufacturer': androidInfo.manufacturer,
        'version': androidInfo.version.release,
        'device': androidInfo.device,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return {
        'model': iosInfo.utsname.machine,
        'systemName': iosInfo.systemName,
        'version': iosInfo.systemVersion,
      };
    }
    return {};
  }

  static Future<Map<String, dynamic>> _getAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return {
      'appName': packageInfo.appName,
      'packageName': packageInfo.packageName,
      'version': packageInfo.version,
      'buildNumber': packageInfo.buildNumber,
    };
  }
}

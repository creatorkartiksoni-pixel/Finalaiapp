import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class IdentityManager {
  static Future<String> generatePanId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      // Combines Model + Hardware to make a unique ID
      return "PAN-${androidInfo.model}-${androidInfo.id.substring(0, 5)}".toUpperCase();
    }
    return "PAN-UNKNOWN";
  }
}

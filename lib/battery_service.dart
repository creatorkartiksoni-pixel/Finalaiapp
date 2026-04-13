import 'package:battery_plus/battery_plus.dart';

class BatteryService {
  var _battery = Battery();

  Future<int> getBatteryLevel() async {
    return await _battery.batteryLevel;
  }

  // Logic for "Bhai, Phone B ko charge pe lagao"
  void checkCriticalLevel(Function(int) onLow) async {
    int level = await getBatteryLevel();
    if (level < 15) {
      onLow(level); // Triggers the PAN Alert
    }
  }
}

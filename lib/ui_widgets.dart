import 'package:flutter/material.dart';

class PanStyle {
  static const Color neonCyan = Color(0xFF00FFFF);
  static const Color darkBg = Color(0xFF121212);

  static BoxDecoration hubCard = BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(15),
    border: Border.all(color: neonCyan.withOpacity(0.3)),
  );
}

// Custom Status Widget for Hub
class DeviceStatusTile extends StatelessWidget {
  final String deviceName;
  final int battery;

  DeviceStatusTile({required this.deviceName, required this.battery});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: PanStyle.hubCard,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(deviceName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text("$battery%", style: TextStyle(color: PanStyle.neonCyan)),
        ],
      ),
    );
  }
}

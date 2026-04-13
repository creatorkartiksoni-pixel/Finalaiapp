import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'ui_widgets.dart';
import 'main.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  // Permission Master Trigger
  Future<void> initHubPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.nearbyWifiDevices,
      Permission.location,
      Permission.systemAlertWindow, // For Ghost Overlay
    ].request();

    if (statuses.values.every((status) => status.isGranted)) {
      // Direct to Dashboard
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HubDashboard())
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bhai, sari permissions chahiye Hub activate karne ke liye!"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PanStyle.darkBg,
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              title: "SMART-PAN HUB",
              subtitle: "Apne sare devices ko ek 'Mesh Network' mein jodo zero cost par.",
              icon: Icons.hub_rounded,
            ),
            buildPage(
              title: "GHOST STORAGE",
              subtitle: "Files ko split karke encrypted network par hide aur manage karo.",
              icon: Icons.security_rounded,
            ),
            buildPage(
              title: "BORROWED NET",
              subtitle: "Range limits ke bina packets borrow karo aur internet share karo.",
              icon: Icons.wifi_tethering_rounded,
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage 
        ? TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.fromHeight(80),
              backgroundColor: PanStyle.neonCyan,
            ),
            onPressed: initHubPermissions,
            child: Text("INITIALIZE HUB X", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            color: PanStyle.darkBg,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () => _controller.jumpToPage(2), child: Text("SKIP", style: TextStyle(color: Colors.grey))),
                TextButton(onPressed: () => _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut), child: Text("NEXT", style: TextStyle(color: PanStyle.neonCyan))),
              ],
            ),
          ),
    );
  }

  Widget buildPage({required String title, required String subtitle, required IconData icon}) {
    return Container(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: PanStyle.neonCyan),
          SizedBox(height: 40),
          Text(title, style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text(subtitle, textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'ui_widgets.dart';
import 'onboarding_screen.dart';
import 'robot_intro_overlay.dart';
import 'identity_manager.dart';
import 'battery_service.dart';
import 'ai_hub.dart';
import 'hardware_controller.dart';
import 'ghost_shield_ui.dart';
import 'network_discovery.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(EditionXApp());
}

class EditionXApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart-PAN Hub Edition X',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: PanStyle.darkBg,
        primaryColor: PanStyle.neonCyan,
      ),
      // App Start Point
      home: OnboardingScreen(), 
    );
  }
}

class HubDashboard extends StatefulWidget {
  @override
  _HubDashboardState createState() => _HubDashboardState();
}

class _HubDashboardState extends State<HubDashboard> {
  String myId = "Loading...";
  int batteryLevel = 0;
  final AiHub _aiHub = AiHub();
  bool _showRobotIntro = true; // First time pop-up logic

  @override
  void initState() {
    super.initState();
    loadHubData();
  }

  // Files integration call
  void loadHubData() async {
    String id = await IdentityManager.generatePanId();
    int bat = await BatteryService().getBatteryLevel();
    setState(() {
      myId = id;
      batteryLevel = bat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDITION X HUB", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shield, color: PanStyle.neonCyan),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GhostShieldUI(shieldType: 'SECURITY'))),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // 1. Device Identity Card
                buildIdentityCard(),
                SizedBox(height: 20),

                // 2. AI Bhai Mode Advice
                buildAiAdviceBox(),
                SizedBox(height: 20),

                // 3. Grid Menu for Hardware & Network
                buildFeatureGrid(),
              ],
            ),
          ),

          // 4. Mono Robot Overlay (Only shows once)
          if (_showRobotIntro)
            RobotIntroOverlay(onDismiss: () {
              setState(() => _showRobotIntro = false);
            }),
        ],
      ),
    );
  }

  Widget buildIdentityCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: PanStyle.neonCard,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("PAN NODE ID", style: TextStyle(color: Colors.white54, fontSize: 12)),
              Text(myId, style: TextStyle(color: PanStyle.neonCyan, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(
            children: [
              Icon(Icons.battery_charging_full, color: batteryLevel < 20 ? Colors.red : Colors.green),
              Text("$batteryLevel%", style: TextStyle(color: Colors.white)),
            ],
          )
        ],
      ),
    );
  }

  Widget buildAiAdviceBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
      child: Text(
        _aiHub.getBhaiAdvice(batteryLevel < 20 ? "battery" : "all good"),
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white70),
      ),
    );
  }

  Widget buildFeatureGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        MenuButton(
          title: "KNOWLEDGE", 
          icon: Icons.psychology, 
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _aiHub.getKnowledgeBase())),
        ),
        MenuButton(
          title: "SCAN NODES", 
          icon: Icons.radar, 
          onTap: () => NetworkDiscovery().discoverNodes(),
        ),
        MenuButton(
          title: "COOL SYSTEM", 
          icon: Icons.ac_unit, 
          onTap: () => HardwareController().coolDownSystem(),
        ),
        MenuButton(
          title: "EYE REST", 
          icon: Icons.remove_red_eye, 
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GhostShieldUI(shieldType: 'EYES_BREAK'))),
        ),
      ],
    );
  }
}

// Custom button for the grid
class MenuButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuButton({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: PanStyle.neonCyan.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: PanStyle.neonCyan, size: 40),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

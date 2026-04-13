import 'package:flutter/material.dart';
import 'ui_widgets.dart';

class RobotIntroOverlay extends StatelessWidget {
  final VoidCallback onDismiss;

  RobotIntroOverlay({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Floating Robot Image
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: PanStyle.neonCyan.withOpacity(0.5), blurRadius: 30)
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/Mono.robo', // Tumhara image path
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.robot, size: 100, color: PanStyle.neonCyan);
                  },
                ),
              ),
            ),
            
            SizedBox(height: 30),
            
            // Robot Dialogue Box
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: PanStyle.neonCyan),
              ),
              child: Column(
                children: [
                  Text(
                    "HELLO SIR! I AM MONO.",
                    style: TextStyle(color: PanStyle.neonCyan, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Main aapke Edition X Hub ko monitor kar raha hoon. Mesh network active hai aur hum safe hain.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 40),
            
            // Action Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PanStyle.neonCyan,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: onDismiss,
              child: Text("THANKS MONO!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'ui_widgets.dart';

class GhostShieldUI extends StatelessWidget {
  final String shieldType; // 'SECURITY' or 'EYES_BREAK'

  GhostShieldUI({required this.shieldType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.95), // 95% Translucent
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              shieldType == 'SECURITY' ? Icons.security_sharp : Icons.visibility_off,
              color: PanStyle.neonCyan,
              size: 80,
            ),
            SizedBox(height: 30),
            Text(
              shieldType == 'SECURITY' 
                ? "GHOST SHIELD ACTIVE" 
                : "BHAI, AANKHON KO REST DO!",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 22, 
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                shieldType == 'SECURITY'
                  ? "Invisible mesh layer is protecting your PAN identity from physical prying eyes."
                  : "Edition X has detected long usage. Take a 5-minute break for your eyes.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white60),
              ),
            ),
            SizedBox(height: 50),
            // Unlock Pattern or Button
            GestureDetector(
              onLongPress: () => Navigator.pop(context), // Secret exit
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: PanStyle.neonCyan.withOpacity(0.5)),
                ),
                child: Icon(Icons.fingerprint, color: PanStyle.neonCyan, size: 40),
              ),
            ),
            Text("\nLong press to deactivate", style: TextStyle(color: Colors.white30, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

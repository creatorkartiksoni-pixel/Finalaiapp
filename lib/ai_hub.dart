import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'hardware_controller.dart';
import 'ui_widgets.dart';

class AiHub {
  // 1. ACTION ENGINE: Direct System Control
  void takeAction(String command) {
    command = command.toLowerCase();
    final controller = HardwareController();

    if (command.contains("cool") || command.contains("heat")) {
      controller.coolDownSystem();
    } else if (command.contains("clean") || command.contains("ram")) {
      controller.clearRamMemory();
    } else if (command.contains("shield") || command.contains("hide")) {
      controller.toggleGhostOverlay(true);
    }
  }

  // 2. KNOWLEDGE INTERFACE: WebView (No API Key Required)
  Widget getKnowledgeBase() {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(PanStyle.darkBg)
      ..loadRequest(Uri.parse('https://www.perplexity.ai')); // Free AI Search

    return Scaffold(
      appBar: AppBar(
        title: Text("AI KNOWLEDGE BASE", style: TextStyle(fontSize: 14)),
        backgroundColor: Colors.black,
      ),
      body: WebViewWidget(controller: controller),
    );
  }

  // 3. BHAI MODE QUICK RESPONSES
  String getBhaiAdvice(String issue) {
    issue = issue.toLowerCase();
    if (issue.contains("battery")) return "Bhai, mesh nodes se power borrow kar raha hoon.";
    if (issue.contains("slow")) return "System junk detect hua hai, clean karu kya?";
    return "Bhai, Edition X optimally chal raha hai. Sab set hai!";
  }
}

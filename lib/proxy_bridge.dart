import 'dart:io';
import 'dart:convert';

class ProxyBridge {
  HttpServer? _server;
  bool isRunning = false;

  // 1. Start Tunnel: Phone A ko 'Internet Provider' banata hai
  Future<void> startBridge(int port) async {
    try {
      _server = await HttpServer.bind(InternetAddress.anyIPv4, port);
      isRunning = true;
      print("Proxy Bridge Active on Port: $port");

      _server!.listen((HttpRequest request) async {
        final client = HttpClient();
        
        try {
          // Request ko internet par forward karna
          final proxyRequest = await client.openUrl(request.method, request.uri);
          
          // Headers copy karna
          request.headers.forEach((name, values) {
            for (var value in values) {
              proxyRequest.headers.add(name, value);
            }
          });

          // Body stream karna
          await proxyRequest.addStream(request);
          final proxyResponse = await proxyRequest.close();

          // Response wapas Phone B ko bhejna
          request.response.statusCode = proxyResponse.statusCode;
          proxyResponse.headers.forEach((name, values) {
            for (var value in values) {
              request.response.headers.add(name, value);
            }
          });

          await request.response.addStream(proxyResponse);
        } catch (e) {
          print("Bridge Error: $e");
        } finally {
          await request.response.close();
          client.close();
        }
      });
    } catch (e) {
      print("Could not start bridge: $e");
    }
  }

  // 2. Stop Tunnel
  void stopBridge() {
    _server?.close();
    isRunning = false;
    print("Proxy Bridge Offline");
  }

  // 3. Status for AI Hub
  String getStatus() {
    return isRunning ? "Sharing Internet" : "Bridge Idle";
  }
}

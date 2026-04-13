import 'dart:io';
import 'dart:typed_data';

class PanEngine {
  ServerSocket? server;
  
  // Start Hub (Server Mode)
  Future<void> startHub() async {
    server = await ServerSocket.bind(InternetAddress.anyIPv4, 4040);
    server?.listen((client) {
      handlePacket(client);
    });
  }

  // Packet Manager: Receiving binary chunks
  void handlePacket(Socket client) {
    client.listen((Uint8List data) {
      print("Received Packet Chunk: ${data.length} bytes");
      // Logic for Ghost Storage or Internet Tunneling goes here
    });
  }

  // Connect to another device
  Future<void> connectToNode(String ip) async {
    Socket socket = await Socket.connect(ip, 4040);
    socket.write('PAN_IDENT_CONNECT');
  }
}

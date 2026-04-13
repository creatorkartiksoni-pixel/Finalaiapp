import 'dart:io';

class StorageAnalyzer {
  // Junk aur badi files dhoondhna
  Future<void> analyzeDeeply() async {
    Directory dir = Directory('/storage/emulated/0/');
    List<FileSystemEntity> files = dir.listSync(recursive: false);
    
    for (var file in files) {
      if (file is File) {
        int sizeInMb = await file.length() ~/ (1024 * 1024);
        if (sizeInMb > 50) {
          print("Ghost Candidate found: ${file.path} ($sizeInMb MB)");
          // In files ko Ghost Storage ke liye mark karo
        }
      }
    }
  }
}

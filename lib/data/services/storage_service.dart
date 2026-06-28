import 'dart:developer' as developer;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';

class StorageService {
  final FirebaseStorage _storage;

  StorageService(this._storage);

  // Pick a file from device
  Future<PlatformFile?> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        return result.files.first;
      }
      return null;
    } catch (e) {
      throw 'Failed to pick file. Please try again.';
    }
  }

  // Upload file to Firebase Storage
  Future<String> uploadFile({
    required String userId,
    required String applicationId,
    required PlatformFile file,
  }) async {
    try {
      print('StorageService: Starting upload for ${file.name}');
      print('StorageService: File extension: ${file.extension}, Size: ${file.size}');
      
      if (file.bytes == null) {
        print('StorageService: ERROR - file.bytes is NULL. This will fail on Web.');
        throw 'File data is missing. Please try re-selecting the file.';
      }

      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.name}';
      final path = 'documents/$userId/$applicationId/$fileName';

      final ref = _storage.ref().child(path);

      print('StorageService: Uploading ${file.bytes!.length} bytes to path: $path');
      
      final uploadTask = await ref.putData(
        file.bytes!,
        SettableMetadata(
          contentType: _getContentType(file.extension ?? ''),
        ),
      );

      final url = await uploadTask.ref.getDownloadURL();
      print('StorageService: Upload successful, URL: $url');
      return url;
    } on FirebaseException catch (e) {
      print('StorageService: FIREBASE ERROR [${e.code}]: ${e.message}');
      throw 'Storage Error: ${e.message}';
    } catch (e) {
      print('StorageService: UNKNOWN ERROR: $e');
      throw 'Failed to upload file. Please try again.';
    }
  }

  // Delete file from Firebase Storage
  Future<void> deleteFile(String downloadUrl) async {
    try {
      final ref = _storage.refFromURL(downloadUrl);
      await ref.delete();
    } catch (e) {
      throw 'Failed to delete file. Please try again.';
    }
  }

  // Get content type from file extension
  String _getContentType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      default:
        return 'application/octet-stream';
    }
  }

  Future<String> uploadKycDocument({
    required String userId,
    required String fileName,
    required PlatformFile file,
  }) async {
    final ref = _storage.ref('kyc/$userId/$fileName');
    await ref.putData(file.bytes!);
    return await ref.getDownloadURL();
  }
}

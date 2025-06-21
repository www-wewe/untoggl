import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';

class StorageService {
  final authService = GetIt.instance.get<FirebaseService>();

  Future<void> pickAndUploadNewProfilePicture() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await Permission.manageExternalStorage.request();
    }
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      throw Exception('Error, old image will be used');
    }
    final fileExtension = image.name.split('.').last;
    final imageBytes = await image.readAsBytes();
    if (imageBytes.isEmpty) {
      throw Exception('Error, old image will be used');
    }

    try {
      final url = FirebaseStorage.instance.ref('profiles');
      final imgRef = url.child(authService.userId);
      await imgRef.putData(imageBytes);
      final downloadUrl = await imgRef.getDownloadURL();
      await authService.updateProfilePicture(downloadUrl);
    } catch (e) {
      throw Exception('Error uploading image');
    }
  }
}

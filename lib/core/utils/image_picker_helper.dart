import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as picker;

enum ImagePickerSourceType {
  camera,
  gallery
}

class ImagePickerHelper {
  static final picker.ImagePicker _picker = picker.ImagePicker();

  static Future<File?> pickImage({
    required ImagePickerSourceType source,
    int imageQuality = 80,
  }) async {
    try {
      final picker.XFile? pickedFile = await _picker.pickImage(
        source: source == ImagePickerSourceType.camera
            ? picker.ImageSource.camera
            : picker.ImageSource.gallery,
        imageQuality: imageQuality,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (file.existsSync()) {
          return file;
        }
      }
      return null;
    } catch (e) {
      debugPrint("Rasm tanlashda xatolik: $e");
      return null;
    }
  }

  static Future<File?> pickImageFromCamera({
    int imageQuality = 80,
  }) async {
    return await pickImage(
      source: ImagePickerSourceType.camera,
      imageQuality: imageQuality,
    );
  }

  static Future<File?> pickImageFromGallery({
    int imageQuality = 80,
  }) async {
    return await pickImage(
      source: ImagePickerSourceType.gallery,
      imageQuality: imageQuality,
    );
  }
}

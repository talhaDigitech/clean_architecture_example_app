import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static Future<File?> pickImage(BuildContext context) async {
    // Use ImagePicker to select an image from the gallery
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        // Call the cropImage function to crop the image
        return File(pickedFile.path);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  // static Future<File?> _cropImage({
  //   required String imagePath,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     final croppedFile = await ImageCropper().cropImage(
  //       sourcePath: imagePath,
  //       uiSettings: [
  //         AndroidUiSettings(
  //           toolbarTitle: 'Crop Image',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false,
  //           aspectRatioPresets: [
  //             CropAspectRatioPreset.square,
  //             CropAspectRatioPreset.ratio3x2,
  //             CropAspectRatioPreset.original,
  //             CropAspectRatioPreset.ratio4x3,
  //             CropAspectRatioPreset.ratio16x9,
  //           ],
  //         ),
  //         IOSUiSettings(
  //           title: 'Crop Image',
  //           aspectRatioPresets: [
  //             CropAspectRatioPreset.square,
  //             CropAspectRatioPreset.ratio3x2,
  //             CropAspectRatioPreset.original,
  //             CropAspectRatioPreset.ratio4x3,
  //             CropAspectRatioPreset.ratio16x9,
  //           ],
  //         ),
  //         WebUiSettings(context: context),
  //       ],
  //     );

  //     if (croppedFile != null) {
  //       return File(croppedFile.path);
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to pick file');
  //   }
  //   return null;
  // }
}

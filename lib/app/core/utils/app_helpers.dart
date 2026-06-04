import 'package:clean_architecture_example_app/app/core/services/registry_service/di.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gal/gal.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';



import 'package:url_launcher/url_launcher.dart';
import 'package:image/image.dart' as img;

import 'package:path_provider/path_provider.dart';

class AppHelpers {
  static Future<void> openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        appPrint('Could not launch url $url');
      }
    } catch (e) {
      appPrint(e);
    }
  }

  static Future<void> openDialPad(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  static Future<void> openEmailClient(String emailAddress) async {
    final uri = Uri(scheme: 'mailto', path: emailAddress);
    try {
      await launchUrl(uri);
    } catch (e, stackTrace) {
      appPrint(e);
      appPrint(stackTrace);
    }
  }

  // static Future<void> saveToGallery(
  //   ScreenshotController screenshotController,
  // ) async {
  //   try {
  //     final image = await screenshotController.capture();
  //     if (image != null) {
  //       final directory = await getTemporaryDirectory();
  //       final path =
  //           '${directory.path}/naikify_receipt_${DateTime.now().millisecondsSinceEpoch}.png';
  //       final file = File(path);
  //       await file.writeAsBytes(image);

  //       // Check/Request permission
  //       final hasPermission = await Gal.hasAccess();
  //       if (!hasPermission) {
  //         await Gal.requestAccess();
  //       }

  //       await Gal.putImage(path, album: 'Naikify');
  //       Prompt.showSuccess("Saved to gallery");
  //     }
  //   } catch (e) {
  //     Prompt.showError("Failed to save image: $e");
  //   }
  // }

  // static Future<File> pickSingleFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'docx', 'doc'],
  //   );
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     return file;
  //   } else {
  //     throw ('Failed to pick file');
  //   }
  // }

  static final ImagePicker _picker = locator<ImagePicker>();

  static Future<XFile?> pickImage() async {
    final hasPermission = await Gal.hasAccess();
    if (!hasPermission) {
      await Gal.requestAccess();
    }
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  static Future<List<XFile>?> pickMultipleImages() async {
    final hasPermission = await Gal.hasAccess();
    if (!hasPermission) {
      await Gal.requestAccess();
    }
    return await _picker.pickMultiImage();
  }

  static Future<XFile?> capture() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }

  // give time like 3 minutes/seconds ago etc
  static String getFormattedDate(DateTime date) {
    DateTime now = DateTime.now().toLocal();
    DateTime newDate = date.toLocal();

    Duration difference = now.difference(newDate);

    int inSeconds = difference.inSeconds;
    int inMinutes = difference.inMinutes;
    int inHours = difference.inHours;
    int inDays = difference.inDays;

    if (inSeconds < 60) {
      return "$inSeconds sec ago";
    } else if (inMinutes < 60) {
      return "$inMinutes min ago";
    } else if (inHours < 24) {
      return "$inHours hr${inHours > 1 ? 's' : ''} ago";
    } else if (inDays == 1) {
      return "Yesterday";
    } else if (inDays < 7) {
      return "$inDays days ago";
    } else if (inDays < 30) {
      int weeks = (inDays / 7).floor();
      return "$weeks week${weeks > 1 ? 's' : ''} ago";
    } else if (inDays < 365) {
      int months = (inDays / 30).floor();
      return "$months month${months > 1 ? 's' : ''} ago";
    } else {
      int years = (inDays / 365).floor();
      return "$years year${years > 1 ? 's' : ''} ago";
    }
  }

  static DateFormat formatter = DateFormat('yyyy-MM-dd');

  static String formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'N/A';
    }
    try {
      return DateFormat('MMM dd, yyyy').format(DateTime.parse(dateString));
    } catch (e) {
      return 'Invalid date';
    }
  }

  static String formatTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'N/A';
    }
    try {
      return DateFormat('h:mm a').format(DateTime.parse(dateString));
    } catch (e) {
      return 'Invalid time';
    }
  }

  static Future<List<XFile?>?> pickMultiple() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile?> images = await picker.pickMultiImage();
    return images;
  }

  static String formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // add method to share multiple files via share_plus package
  // static Future<void> shareMultipleFiles(List<XFile> filePaths) async {
  //   try {
  //     await Share.shareXFiles(filePaths);
  //   } catch (e) {
  //     throw Exception('Could not share files: $e');
  //   }
  // }

  static void closeKeypad() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<XFile> compressXFileWithImagePackage(
    XFile xfile, {
    int quality = 70,
  }) async {
    // 1. Get the temporary directory path in the main isolate.
    final tempDir = await getTemporaryDirectory();
    final tempPath = tempDir.path;

    // 2. Pass the path string to the compute function.
    return await compute(_compress, _CompressParams(xfile, quality, tempPath));
  }

  // This function now runs entirely in the background without platform channel calls.
  static Future<XFile> _compress(_CompressParams params) async {
    // We no longer need to await xfile.readAsBytes() here,
    // as the compute function handles passing the necessary data.
    // However, keeping it async is fine and good practice.
    final imageBytes = await params.xfile.readAsBytes();
    final image = img.decodeImage(imageBytes);

    if (image == null) {
      throw Exception("Invalid image format");
    }

    final compressedBytes = img.encodeJpg(image, quality: params.quality);

    // 3. Use the pre-fetched temporary path.
    final targetPath =
        "${params.tempPath}/${basenameWithoutExtension(params.xfile.path)}_compressed.jpg";

    final compressedFile = File(targetPath)..writeAsBytesSync(compressedBytes);

    return XFile(compressedFile.path);
  }
}

class _CompressParams {
  final XFile xfile;
  final int quality;
  final String tempPath; // Path to the temporary directory.

  _CompressParams(this.xfile, this.quality, this.tempPath);
}

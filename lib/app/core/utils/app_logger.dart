import 'dart:developer';
import 'package:flutter/foundation.dart';

void appPrint(Object? message) {
  if (kDebugMode) {
    debugPrint("[PRINT] [WINMETER APP] 🔋 => $message");
  }
}

void appLog(Object? message) {
  if (kDebugMode) {
    log("[LOG] [WINMETER APP] 🔋 => $message");
  }
}

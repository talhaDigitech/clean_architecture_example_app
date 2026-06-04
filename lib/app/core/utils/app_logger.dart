import 'dart:developer';

import 'package:flutter/foundation.dart';

void appPrint(message) {
  if (kDebugMode) {
    print("[PRINT] [NAKIKIFY-APP] 🎁 => $message");
  }
}

void appLog(message) {
  if (kDebugMode) {
    log("[LOG] [NAKIKIFY-APP] 🎁 => $message");
  }
}

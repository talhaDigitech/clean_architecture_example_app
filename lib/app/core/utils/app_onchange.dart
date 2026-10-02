import 'package:flutter/material.dart';

class AppOnchange {
  void removeSpacesAndCapitalAlphabets(TextEditingController controller) {
    final originalText = controller.text;
    final cleanText = originalText.toLowerCase().replaceAll(' ', '');
    if (cleanText != originalText) {
      controller.value = controller.value.copyWith(
        text: cleanText,
        selection: TextSelection.collapsed(offset: cleanText.length),
        composing: TextRange.empty,
      );
    }
  }

  void removeSpaces(TextEditingController controller) {
    final originalText = controller.text;
    final cleanText = originalText.replaceAll(' ', '');
    if (cleanText != originalText) {
      controller.value = controller.value.copyWith(
        text: cleanText,
        selection: TextSelection.collapsed(offset: cleanText.length),
        composing: TextRange.empty,
      );
    }
  }
}

import 'package:flutter/services.dart';

/// App Formatters
///
class AppFormatters {
  /// Centralized text input formatters for consistent data entry.
  AppFormatters._();

  /// Formats text to capitalize the first letter of each word.
  static TextInputFormatter get nameCapitalization => _TitleCaseFormatter();

  /// Formats email to be lowercase.
  static TextInputFormatter get emailLowercase => _LowerCaseFormatter();

  /// Formats Pakistani CNIC (XXXXX-XXXXXXX-X).
  static TextInputFormatter get cnic => _CnicFormatter();

  /// Formats Date as DD/MM/YYYY
  static TextInputFormatter get date => _DateFormatter();

  /// Formats Expiry Date as MM/YY
  static TextInputFormatter get expiryDate => _ExpiryDateFormatter();

  /// Digits only formatter.
  static TextInputFormatter get digitsOnly =>
      FilteringTextInputFormatter.digitsOnly;

  /// Phone number formatter (max limit 11 digits)
  static TextInputFormatter get phoneNumber => _PhoneNumberFormatter();

  /// Pakistan mobile: locked "+92 " prefix, national part must start with 3, max 10 digits (e.g. +92 3132076068).
  static TextInputFormatter get phonePakistan => _PhonePakistanFormatter();

  /// Formatter for any country with its specific dial code and rules.
  static TextInputFormatter countryPhone(String dialCode, int maxNationalDigits) =>
      _CountryPhoneFormatter(dialCode, maxNationalDigits);

  /// Formatter that enforces a locked prefix (e.g., '+92').
  static TextInputFormatter lockedPrefix(String prefix) =>
      _LockedPrefixFormatter(prefix);

  /// Formatter that enforces a locked prefix and limits digits after it.
  /// [prefix] e.g. '+92', [maxNationalDigits] e.g. 10 for Pakistan.
  static TextInputFormatter lockedPrefixWithMaxLength(
    String prefix,
    int maxNationalDigits,
  ) => _CountryPhoneFormatter(prefix, maxNationalDigits);

  static TextInputFormatter get noLeadingZero => _NoLeadingZeroFormatter();
  // static TextInputFormatter get emailFormatter => _EmailFormatter();
}

/// Formatter that prevents the text from starting with '0'.
class _NoLeadingZeroFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith('0')) {
      String newText = newValue.text;
      while (newText.startsWith('0')) {
        newText = newText.substring(1);
      }
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    return newValue;
  }
}

/// Formatter for Title Case (First letter of each word capitalized)
class _TitleCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final words = newValue.text.split(' ');
    final capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    final newText = capitalizedWords.join(' ');

    // Maintain selection/cursor position logic
    return newValue.copyWith(text: newText, selection: newValue.selection);
  }
}

/// Formatter for Lowercase (e.g., for Emails)
class _LowerCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

/// Formatter for Pakistani CNIC (XXXXX-XXXXXXX-X)
class _CnicFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('-', '');
    // Ensure only digits
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Prevent exceeding max dimensions
    if (text.length > 13) {
      text = text.substring(0, 13);
    }

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 5 || i == 12) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// Formatter for Date (DD/MM/YYYY)
class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('/', '');
    // Ensure only digits
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Max length for DDMMYYYY is 8 digits
    if (text.length > 8) {
      text = text.substring(0, 8);
    }

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// Formatter for Expiry Date (MM/YY)
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll('/', '');
    // Ensure only digits
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Max length for MMYY is 4 digits
    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// Formatter that prevents deleting a specific prefix.
class _LockedPrefixFormatter extends TextInputFormatter {
  final String prefix;

  _LockedPrefixFormatter(this.prefix);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!newValue.text.startsWith(prefix)) {
      return oldValue;
    }
    return newValue;
  }
}

/// Formatter that handles country-specific phone rules.
class _CountryPhoneFormatter extends TextInputFormatter {
  final String dialCode;
  final int maxNationalDigits;

  _CountryPhoneFormatter(this.dialCode, this.maxNationalDigits);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If they try to delete the dial code entirely, keep it
    if (!newValue.text.startsWith(dialCode)) {
      return oldValue;
    }

    String nationalPart = newValue.text.substring(dialCode.length);
    nationalPart = nationalPart.replaceAll(RegExp(r'[^0-9]'), '');

    // Pakistan rules: national part must start with '3'
    if (dialCode == '+92') {
      if (nationalPart.startsWith('0')) {
        nationalPart = nationalPart.substring(1);
      }
      if (nationalPart.isNotEmpty && !nationalPart.startsWith('3')) {
        // Force it to be a mobile number starting with 3
        nationalPart = '3' + (nationalPart.length > 9 ? nationalPart.substring(0, 9) : nationalPart);
      }
    } else {
      // General rule: strip leading zero for international format
      if (nationalPart.startsWith('0')) {
        nationalPart = nationalPart.substring(1);
      }
    }

    if (nationalPart.length > maxNationalDigits) {
      nationalPart = nationalPart.substring(0, maxNationalDigits);
    }

    final result = dialCode + nationalPart;
    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}

/// Formatter for Phone Number (XXXXXXXXXXX)
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow digits and a leading '+'
    var text = newValue.text;

    // Strip everything except digits and '+'
    text = text.replaceAll(RegExp(r'[^\d+]'), '');

    // Ensure '+' only appears at the start
    if (text.contains('+')) {
      if (!text.startsWith('+')) {
        text = text.replaceAll('+', '');
      } else {
        // Keep only the first '+'
        text = '+${text.substring(1).replaceAll('+', '')}';
      }
    }

    // Max length for phone number is 13 characters (+923XXXXXXXXX)
    if (text.length > 13) {
      text = text.substring(0, 13);
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

const String _pkPrefix = '+92';

/// Formatter for Pakistan mobile: "+92" locked, then digits starting with 3, max 10 (e.g. +923132076068).
class _PhonePakistanFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String national = '';

    if (newValue.text.startsWith(_pkPrefix)) {
      national = newValue.text.substring(_pkPrefix.length).replaceAll(RegExp(r'[^0-9]'), '');
    } else {
      final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (digits.length >= 12 && digits.startsWith('92') && digits[2] == '3') {
        national = digits.substring(2, 12);
      } else if (digits.startsWith('92')) {
        final len = (digits.length - 2).clamp(0, 10);
        national = digits.length > 2 ? digits.substring(2, 2 + len) : '';
      } else if (digits.startsWith('3')) {
        national = digits.substring(0, digits.length > 10 ? 10 : digits.length);
      } else if (digits.length >= 11 && digits.startsWith('0') && digits[1] == '3') {
        national = digits.substring(1, 11);
      } else if (digits.isNotEmpty) {
        national = '3' + digits.substring(0, digits.length > 9 ? 9 : digits.length);
      }
    }

    // Block leading zero: national part must start with 3 (Pakistani mobile)
    if (national.isNotEmpty && national[0] == '0') {
      return oldValue;
    }
    if (national.isNotEmpty && national[0] != '3') {
      national = '3' + national.substring(0, national.length > 9 ? 9 : national.length);
    }
    national = national.length > 10 ? national.substring(0, 10) : national;

    final result = _pkPrefix + national;
    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}

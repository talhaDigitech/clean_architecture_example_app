/// App Validators
///
/// Centralized logic for form field validation.
class AppValidators {
  AppValidators._();

  /// Validates that the field is not empty.
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? '$fieldName is required'
          : 'This field is required';
    }
    return null;
  }

  /// Validates a Pakistani mobile number.
  /// Supported formats:
  /// - 03XXXXXXXXX (11 digits)
  /// - 923XXXXXXXXX (12 digits)
  /// - +923XXXXXXXXX (13 digits)
  static String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }

    final cleaned = value.trim();

    if (cleaned.startsWith('0')) {
      if (cleaned.length < 11) {
        return 'Phone number starting with 0 must be at least 11 digits';
      }
    } else if (cleaned.startsWith('92')) {
      if (cleaned.length < 12) {
        return 'Phone number starting with 92 must be at least 12 digits';
      }
    } else if (cleaned.startsWith('+92')) {
      if (cleaned.length < 13) {
        return 'Phone number starting with +92 must be at least 13 digits';
      }
    } else if (cleaned.startsWith('3')) {
      if (cleaned.length != 10) {
        return 'Phone number starting with 3 must be 10 digits';
      }
    } else {
      return 'Phone number should start with 0, 3, or 92';
    }

    // Basic digit check
    final numericPart = cleaned.startsWith('+')
        ? cleaned.substring(1)
        : cleaned;
    if (!RegExp(r'^\d+$').hasMatch(numericPart)) {
      return 'Phone number must contain only digits';
    }

    return null;
  }

  /// Validates Full Name
  /// - Must not be empty
  /// - Maximum length of 200 characters
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    if (value.length > 200) {
      return 'Name must be less than 200 characters';
    }
    return null;
  }

  /// Validates a phone number with an international dial code.
  /// Use [phoneWithDialCode] when country code is known for country-specific rules.
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final cleaned = value.trim().replaceAll(RegExp(r'[\s\-\(\)]'), '');
    // Generic international format: + followed by 7-15 digits
    final phoneRegex = RegExp(r'^\+\d{12,15}$');
    if (!phoneRegex.hasMatch(cleaned)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Country-specific maximum digits after dial code (national number length).
  static const Map<String, int> dialCodeMaxDigits = {
    '+92': 10, // Pakistan
    '+1': 10, // USA, Canada
    '+44': 11, // UK
    '+91': 10, // India
    '+971': 9, // UAE
    '+966': 9, // Saudi Arabia
    '+20': 10, // Egypt
    '+27': 9, // South Africa
    '+62': 12, // Indonesia
    '+60': 9, // Malaysia
    '+65': 8, // Singapore
    '+81': 10, // Japan
    '+86': 11, // China
    '+49': 11, // Germany
    '+33': 9, // France
    '+90': 10, // Turkey
    '+880': 10, // Bangladesh
    '+93': 9, // Afghanistan
    '+98': 10, // Iran
  };

  /// Pakistan mobile: must start with 3 after +92 (3XX XXXXXXX).
  static final RegExp _pkMobileRegex = RegExp(r'^\+92[3]\d{9}$');

  /// Validates a phone number with country-specific rules.
  /// [dialCode] e.g. '+92', '+1', '+44'. Uses generic rules for unknown countries.
  static String? phoneWithDialCode(String? value, String dialCode) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final cleaned = value.trim().replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (!cleaned.startsWith(dialCode)) {
      return 'Please enter a valid $dialCode phone number';
    }

    final nationalNumber = cleaned.substring(dialCode.length);
    if (nationalNumber.isEmpty) {
      return 'Please enter your phone number';
    }

    if (!RegExp(r'^\d+$').hasMatch(nationalNumber)) {
      return 'Phone number can only contain digits';
    }

    // Pakistan: 10 digits, mobile must start with 3
    if (dialCode == '+92') {
      if (nationalNumber.length != 10) {
        return 'Phone number must be 10 digits (e.g. 3001234567)';
      }
      if (!_pkMobileRegex.hasMatch(cleaned)) {
        return 'Pakistani mobile numbers must start with 3';
      }
      return null;
    }

    // Validation for other known countries
    if (dialCodeMaxDigits.containsKey(dialCode)) {
      final expectedLength = dialCodeMaxDigits[dialCode]!;
      if (nationalNumber.length != expectedLength) {
        return 'Phone number for $dialCode must be $expectedLength digits';
      }
      return null;
    }

    // Default validation for all other countries
    const minDigits = 7;
    const maxDigits = 15;

    if (nationalNumber.length < minDigits) {
      return 'Phone number must be at least $minDigits digits';
    }
    if (nationalNumber.length > maxDigits) {
      return 'Phone number cannot exceed $maxDigits digits';
    }

    return null;
  }

  /// Validates an email address.
  /// - Lowercase letters check (logic should be in formatter, validation checks format)
  /// - Top-Level Domain: minimum 2 letters after dot
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    // Validates basic email format and min 2 letters for the domain suffix
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validates Future Date (DD/MM/YYYY)
  static String? futureDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required';
    }

    final dateRegex = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$');
    if (!dateRegex.hasMatch(value)) {
      return 'Invalid date format (DD/MM/YYYY)';
    }

    final match = dateRegex.firstMatch(value)!;
    final day = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final year = int.parse(match.group(3)!);

    if (month < 1 || month > 12) {
      return 'Invalid month';
    }

    if (day < 1 || day > 31) {
      return 'Invalid day';
    }

    // Basic day check (not exhaustive for leap years etc, but good enough for simple validation)
    // Could enhance with DateTime logic
    try {
      final date = DateTime(year, month, day);
      if (date.year != year || date.month != month || date.day != day) {
        return 'Invalid date';
      }

      final now = DateTime.now();
      // Reset time for fair comparison
      final today = DateTime(now.year, now.month, now.day);

      if (!date.isAfter(today)) {
        return 'Date must be in the future';
      }
    } catch (e) {
      return 'Invalid date';
    }

    return null;
  }

  /// Validates Future Expiry Date (MM/YY)
  static String? futureExpiryDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Expiry date is required';
    }

    final dateRegex = RegExp(r'^(\d{2})/(\d{2})$');
    if (!dateRegex.hasMatch(value)) {
      return 'Invalid format (MM/YY)';
    }

    final match = dateRegex.firstMatch(value)!;
    final month = int.parse(match.group(1)!);
    final yearSuffix = int.parse(match.group(2)!);

    if (month < 1 || month > 12) {
      return 'Invalid month';
    }

    // Convert YY to YYYY (assume 2000s)
    final year = 2000 + yearSuffix;

    // Check if date is in future.
    // Expiry date means the card is valid THROUGH that month.
    // So we check if the END of that month is in the future.
    // Or strictly if the month/year is not in the past.

    final now = DateTime.now();
    // Expiry month/year
    final expiry = DateTime(year, month);

    // If strict future check (e.g. must be valid TODAY):
    // Cards expiring this month are valid.
    // So if (expiry month < current month AND expiry year <= current year) -> expired.

    final currentMonthStart = DateTime(now.year, now.month);

    if (expiry.isBefore(currentMonthStart)) {
      return 'Card has expired';
    }

    return null;
  }

  /// Validates Pakistani CNIC number (XXXXX-XXXXXXX-X)
  static String? cnic(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'CNIC is required';
    }
    final cnicRegex = RegExp(r'^\d{5}-\d{7}-\d{1}$');
    if (!cnicRegex.hasMatch(value.trim())) {
      return 'Please enter a valid CNIC (e.g., 12345-6789012-3)';
    }
    return null;
  }

  /// Validates dropdown selection
  static String? dropdown(dynamic value, [String? fieldName]) {
    if (value == null || (value is String && value.isEmpty)) {
      return fieldName != null
          ? 'Please select a $fieldName'
          : 'Please make a selection';
    }
    return null;
  }

  /// Validates password strength (min 6 characters).
  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }
}

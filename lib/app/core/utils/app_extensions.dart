

extension AppStrings on String {
  String get twoDigits => toString().padLeft(2, '0');

  String get commaSeparatedString {
    return toString().replaceAll('[', '').replaceAll(']', '');
  }

  String get formatDuration {
    try {
      final parts = split(':');
      if (parts.length == 2) {
        final minutes = int.tryParse(parts[0]) ?? 0;
        final seconds = int.tryParse(parts[1]) ?? 0;
        if (minutes < 1) {
          return '$minutes Hrs';
        }
        return '$minutes Hrs $seconds Sec';
      } else if (parts.length == 3) {
        final hours = int.tryParse(parts[0]) ?? 0;
        final minutes = int.tryParse(parts[1]) ?? 0;
        if (hours < 1) {
          return '$minutes Mins';
        }
        return '$hours Hrs $minutes Min';
      } else {
        return this;
      }
    } catch (e) {
      return this;
    }
  }

  String get filterException {
    if (contains("Exception: ")) {
      return replaceAll("Exception: ", '');
    }
    return this;
  }
}

// extension Spacing on num {
//   SizedBox get ph => SizedBox(height: toDouble().h);

//   SizedBox get pw => SizedBox(width: toDouble().w);

//   String get toCommaSeparated {
//     return NumberFormat('#,##0.00').format(this);
//   }
// }

extension DateTimeFormatting on String {
  String toCustomFormat() {
    try {
      final dateTime = DateTime.parse(this).toLocal();
      // Extract parts
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final date =
          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      return "$hour:$minute • $date";
    } catch (e) {
      return this; // fallback if parsing fails
    }
  }
}

extension DateFormattingExtension on String {
  String get capitalizeWord {
    return split(' ') // Split the string into words
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
              : word,
        ) // Capitalize the first letter of each word and make the rest lowercase
        .join(' '); // Join the words back into a single string
  }

  String get capitalizeSentence {
    return isNotEmpty
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : this;
  }

  String toLocalDateOnly() {
    try {
      final utcDate = DateTime.parse(this);
      final localDate = utcDate.toLocal();

      return "${localDate.year}-"
          "${localDate.month.toString().padLeft(2, '0')}-"
          "${localDate.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return this; // agar parse fail ho jaye
    }
  }
}

// formate data and time extension name "formateTime" from this formate "2026-03-04T04:51:27.110Z" to "04:51 AM - 04 Mar 2026"
extension FormateTime on String {
  String toFormateTime() {
    try {
      final dateTime = DateTime.parse(this).toLocal();
      // Extract parts
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final date =
          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      return "$hour:$minute • $date";
    } catch (e) {
      return this; // fallback if parsing fails
    }
  }
}


// First letter and last of each word like Talha Azeem Baig to TB
// extension on String {
//  String get initials {
//     final words = trim().split(' ').where((w) => w.isNotEmpty).toList();

//     if (words.isEmpty) return '';

//     if (words.length == 1) {
//       return words.first[0].toUpperCase();
//     }

//     return (words.first[0] + words.last[0]).toUpperCase();
//   }
// }
import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final String code;
  final String emoji;
  final String capital;
  final String currency;
  final String name;

  const CountryCard({
    super.key,
    required this.code,
    required this.emoji,
    required this.capital,
    required this.currency,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Emoji / Flag
          Text(emoji, style: const TextStyle(fontSize: 32)),

          const SizedBox(width: 12),

          // Country Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text("Capital: $capital"),
                Text("Currency: $currency"),
                Text("Code: $code"),
              ],
            ),
          ),

          // Arrow or action
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}

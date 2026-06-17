
import 'package:flutter/material.dart';

class AnimeCard extends StatelessWidget {
  final String englishTitle;
  final String nativeTitle;
  final String imageUrl;
  final String description;

  const AnimeCard({
    super.key,
    required this.englishTitle,
    required this.nativeTitle,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final cleanDescription = description
        .replaceAll(RegExp(r'<br\s*/?>'), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .trim();

    return Container(
      
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 95,
                height: 135,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  width: 95,
                  height: 135,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: SizedBox(
                height: 135,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      englishTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      nativeTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: Text(
                        cleanDescription,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade800,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

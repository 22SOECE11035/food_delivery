import 'package:flutter/material.dart';

class StarRatings extends StatelessWidget {
  final double rating;

  const StarRatings({
    super.key,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    int fullStars =
        rating.floor(); // Full stars based on the integer part of the rating
    bool hasHalfStar =
        (rating - fullStars) >= 0.5; // Half star if the decimal is >= 0.5
    int emptyStars =
        5 - fullStars - (hasHalfStar ? 1 : 0); // Remaining empty stars

    return Row(
      children: [
        // Full stars
        for (int i = 0; i < fullStars; i++)
          const Icon(Icons.star, color: Colors.amber),

        // Half star if applicable
        if (hasHalfStar) const Icon(Icons.star_half, color: Colors.amber),

        // Empty stars
        for (int i = 0; i < emptyStars; i++)
          const Icon(Icons.star_border, color: Colors.amber),

        const SizedBox(width: 10),

        // Display the rating number
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

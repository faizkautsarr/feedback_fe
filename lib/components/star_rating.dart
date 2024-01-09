import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;

  const StarRating({super.key, required this.rating});
  final int maxRating = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < maxRating; i++)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    "assets/star_empty.png",
                    width: 34,
                    filterQuality: FilterQuality.high,
                    gaplessPlayback: true,
                  ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < rating; i++)
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    "assets/star_filled.png",
                    width: 34,
                    filterQuality: FilterQuality.high,
                    gaplessPlayback: true,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}

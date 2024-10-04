import 'package:flutter/material.dart';

class MovieCardAndTitle extends StatelessWidget {
  final String imageUrl;
  final String movieTitle;

  const MovieCardAndTitle({
    super.key,
    required this.imageUrl,
    required this.movieTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          width: 145,
          height: 145,
          child: Image.network(
            imageUrl,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 100,
          child: Text(
            movieTitle,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              height: 1.3,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

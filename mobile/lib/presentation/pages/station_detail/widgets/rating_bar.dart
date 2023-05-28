import 'package:flutter/material.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final double fontSize;
  final bool readOnly;
  final void Function(double)? onRatingUpdate;

  const RatingBar({
    Key? key,
    required this.rating,
    this.size = 30,
    this.fontSize = 14,
    this.readOnly = false,
    this.onRatingUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ..._buildRatingBar(context),
        const SizedBox(width: 5),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _buildRatingBar(BuildContext context) {
    return List.generate(
      5,
      (index) => InkWell(
        onTap: readOnly
            ? null
            : () {
                if (onRatingUpdate != null) {
                  onRatingUpdate!(index + 1.0);
                }
              },
        child: Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating.ceil()
                  ? Icons.star_half
                  : Icons.star_border,
          color: Colors.amber,
          size: size,
        ),
      ),
    );
  }
}

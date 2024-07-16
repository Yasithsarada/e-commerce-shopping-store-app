import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

class RatingSamllView extends StatelessWidget {
  RatingSamllView(
      {super.key, required this.rating, this.spacing, this.sizeEntered});
  final double rating;
  final double? spacing;
  final double? sizeEntered;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PannableRatingBar(
          rate: rating,
          onChanged: (value) {},
          // onHover: updateRating,
          spacing: spacing ?? 0,
          items: List.generate(
            5,
            (index) => RatingWidget(
              selectedColor: Colors.amber,
              unSelectedColor: Colors.grey,
              child: Icon(
                Icons.star,
                size: sizeEntered ?? 15,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(rating.toString())
      ],
    );
  }
}

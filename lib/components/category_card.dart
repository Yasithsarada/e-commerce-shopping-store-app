import 'package:flutter/material.dart';
import 'package:online_shopping_store/constants.dart';

class CategeryCard extends StatelessWidget {
  const CategeryCard({
    super.key,
    required this.categoryName,
    required this.activeCat,
    required this.index,
  });

  final String categoryName;
  final int activeCat;
  final int index;

  @override
  Widget build(BuildContext context) {
    // print(activeCat);
    // print(index);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryName,
            // style: Theme.of(context)
            //     .textTheme
            //     .bodyMedium!
            //     .copyWith(fontWeight: FontWeight.bold),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4.0, bottom: 0.0),
            width: 30,
            height: 2,
            color: index == activeCat ? Colors.black : Colors.transparent,
          )
        ],
      ),
    );
  }
}

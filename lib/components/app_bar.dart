import 'package:flutter/material.dart';
import 'package:online_shopping_store/constants.dart';

class AppBarDeveloped extends StatelessWidget {
  const AppBarDeveloped({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(
        Icons.arrow_back,
        color: kTextColor,
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: kTextColor,
            )),
        const Icon(Icons.shopping_cart)
      ],
    );

  }
}

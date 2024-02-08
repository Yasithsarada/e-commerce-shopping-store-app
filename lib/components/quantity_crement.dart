import 'package:flutter/material.dart';

class QuantityCrement extends StatelessWidget {
  const QuantityCrement({
    super.key,
    required this.icon,
    required this.onPress,
  });
  final IconData icon;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 32,
      child: IconButton.outlined(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13))),
            padding: MaterialStatePropertyAll(EdgeInsets.all(0.0)),
          ),
          onPressed: onPress,
          icon: Icon(icon)),
    );
  }
}

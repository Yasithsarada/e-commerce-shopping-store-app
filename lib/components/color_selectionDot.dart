import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_store/constants.dart';

class ColorSelectionDot extends StatelessWidget {
  const ColorSelectionDot({
    super.key,
    required this.color,
    required this.isSelected,
  });
  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.0, right: kDefaultPaddin / 2),
      height: 24,
      width: 24,
      padding: EdgeInsets.all(2.5),
      decoration: BoxDecoration(
          // color: Colors.black54,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? color : Colors.transparent)),
      child: DecoratedBox(
          decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      )),
    );
  }
}

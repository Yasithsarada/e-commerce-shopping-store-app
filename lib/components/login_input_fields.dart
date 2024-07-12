import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText;
  final String? prefix;
  final Color fillColor;
  final TextEditingController _controller;
  final bool obscureController;
  final TextInputType? textInputType;
  final int? maxlines;
  CustomInputField(
      this.hintText, this.fillColor, this._controller, this.obscureController,
      {super.key, this.textInputType, this.maxlines, this.prefix});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: TextField(
          maxLines: maxlines ?? 1,
          obscureText: obscureController,
          controller: _controller,
          // maxLength: 50,
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide.none),
            // hintText: hintText,
            prefixText: prefix ?? "",
            label: Text(
              hintText,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          keyboardType: textInputType ?? TextInputType.text,
        ));
  }
}

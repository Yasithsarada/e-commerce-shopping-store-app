// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final BuildContext context;
  final String msg;
  final String alternative;
  final String btnText;
  const   DialogBox(
    this.context,
    this.msg,
    this.alternative,
    this.btnText, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(msg),
            Text(alternative),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(btnText),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void dialogBox(
    BuildContext context, String msg, String alternative, String btnText) {
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return DialogBox(context, msg, alternative, btnText);
    },
  );
}

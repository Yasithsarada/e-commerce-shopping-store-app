import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping_store/components/dialogbox.dart';

void httpresponseHandler(
    {required BuildContext context,
    required http.Response response,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      dialogBox(context, jsonDecode(response.body)['message'],
          "Please try again..", "Try again");
      break;
    case 401:
      dialogBox(context, jsonDecode(response.body)['message'],
          "Please try again..", "Try again");
      break;
    case 500:
      dialogBox(context, jsonDecode(response.body)['message'],
          "Please try again..", "Try again");
      break;

    default:
      dialogBox(context, jsonDecode(response.body)['message'],
          "Please try again..", "Try again");
      break;
  }
}

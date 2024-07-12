import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:online_shopping_store/components/dialogbox.dart';
import 'package:online_shopping_store/components/response_handler.dart';
import 'package:online_shopping_store/global_content.dart';
import 'package:online_shopping_store/models/user.dart';
import 'package:online_shopping_store/provider/user_provider.dart';
import 'package:online_shopping_store/screens/central.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<String> scopes = <String>[
  'profile',
  'email',
  // 'https://www.googleapis.com/auth/contacts.readonly',
];

class AuthService {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: 'your-client_id.apps.googleusercontent.com',
    scopes: scopes,
  );
  void signUpUser(
      {required String email,
      required String password,
      required String username,
      required BuildContext context}) async {
    try {
      final client = RetryClient(http.Client());
      print(email);
      print(password);
      print(username);
      User newUser = User(
          id: '',
          username: username,
          email: email,
          password: password,
          token: '',
          googleId: "",
          imageUrl: "");

      var response = await client.post(
        Uri.http(uri, '/api/auth/signUp'),
        body: newUser.toJson(),
        headers: {'Content-Type': 'application/json'},
      );

      // print("$uri/api/auth/signUp");
      // http.Response response = await http.post(
      //   Uri.parse("$uri/api/auth/signUp"),
      //   body: user.toJson(),
      //   headers: {'Content-Type': 'application/json'},
      // );
      print("worked");
      if (!context.mounted) return;
      httpresponseHandler(
          context: context,
          response: response,
          onSuccess: () {
            dialogBox(context, "Account creation Successfull.. ",
                "Login with same credentials", "Go back");
          });
    } catch (e) {
      dialogBox(context, jsonDecode(e.toString()), "Retry ", "Try again");
    }
  }

  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final client = RetryClient(http.Client());

    print("sigining");
    print("$uri/api/auth/signIn");
    // print(email);
    // http.Response response = await http.post(
    //   Uri.parse("$uri/api/auth/signIn"),
    //   body: jsonEncode({"email": email, "password": password}),
    //   headers: {'Content-Type': 'application/json'},
    // );

    var response = await client.post(
      Uri.http(uri, '/api/auth/signIn'),
      body: jsonEncode({"email": email, "password": password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (!context.mounted) return;
    httpresponseHandler(
        context: context,
        response: response,
        onSuccess: () async {
          print(response.body);
          SharedPreferences sharedPref = await SharedPreferences.getInstance();
          await sharedPref.setString(
              'x-auth-token', jsonDecode(response.body)['token']);
          if (!context.mounted) return;

          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
          print("until");
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => CentralPage()));
        });
  }

  void isUserActive(BuildContext context) async {
    final SharedPreferences shpref = await SharedPreferences.getInstance();
    final token = shpref.getString('x-auth-token');
    final client = RetryClient(http.Client());
    print("isUserActive [[[[[[[[[[[[[]]]]]]]]]]]]] : $token");
    if (token == null) shpref.setString('x-auth-token', "");
    // http.Response response = await http.get(
    //     Uri.parse('$uri/api/auth/isSessionActive'),
    //     headers: <String, String>{'x-auth-token': token!});
    var response = await client.get(
      Uri.http(uri, '/api/auth/isSessionActive'),
      headers: <String, String>{'x-auth-token': token!},
    );
    if (response.statusCode == 401) {
      final SharedPreferences shpref = await SharedPreferences.getInstance();
      shpref.setString('x-auth-token', "");
    }
    if (!context.mounted) return;

    httpresponseHandler(
        context: context,
        response: response,
        onSuccess: () async {
          final SharedPreferences shpref =
              await SharedPreferences.getInstance();
          shpref.setString('x-auth-token', jsonDecode(response.body)['token']);
          if (!context.mounted) return;
          Provider.of<UserProvider>(context, listen: false)
              .setUser(response.body);
        });
  }

  Future<void> handleSGoogleignIn({required BuildContext context}) async {
    try {
      final SharedPreferences shpref = await SharedPreferences.getInstance();
      final token = shpref.getString('x-auth-token');

      // await _googleSignIn.signIn();
      print("sign in google");
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final client = RetryClient(http.Client());

        print("user ${user}");
        print(user.email);
        print(user.displayName);

        //   final userAcc = UserModel(
        //   email: user.email,
        //   name: user.displayName ?? '',
        //   profilePic: user.photoUrl ?? '',
        //   uid: '',
        //   token: '',
        // );
        final newUser = User(
          id: '',
          username: user.displayName ?? '',
          email: user.email,
          token: '',
          password: '',
          googleId: user.id,
          imageUrl: user.photoUrl ?? '',
        );
        var response = await client.post(
          Uri.http(uri, '/api/auth/signInWithGoogle'),
          body: newUser.toJson(),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode != 200) {
          shpref.setString('x-auth-token', "");
        }

        // http.Response response = await http.post(
        //   Uri.parse("$uri/api/auth/signUp",
        //   ),
        //   body: newUser.toJson(),
        //   headers: {'Content-Type': 'application/json'},
        // );
        print("google sign in worked");
        if (!context.mounted) return;
        httpresponseHandler(
            context: context,
            response: response,
            onSuccess: () async {
              print("response ${jsonDecode(response.body)}");
              final responseData = jsonDecode(response.body);
              shpref.setString(
                  // 'x-auth-token', jsonDecode(response.body)['token']);
                  'x-auth-token',
                  responseData['token']);
              Provider.of<UserProvider>(context, listen: false)
                  .setUser(response.body);
              dialogBox(context, "Successfully logged in.. ", "yoooo", "close");
            });
      }
    } catch (error) {
      print(error);
      dialogBox(context, jsonDecode(error.toString()), "Retry ", "Try again");
    }
  }
}

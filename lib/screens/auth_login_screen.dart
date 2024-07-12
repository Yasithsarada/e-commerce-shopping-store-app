import 'package:http/retry.dart';
import 'package:online_shopping_store/global_content.dart';
import 'package:online_shopping_store/screens/auth_signup_screens.dart';
import 'package:online_shopping_store/services/auth_services.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService authService = AuthService();

  // Future<void> googleLogin() async {
  //   print("going to call");
  //   final client = RetryClient(http.Client());

  //   try {
  //     print("url : $uri");
  //     // String url = Uri.http(uri, '/ass') as String;
  //     // print("url 2222222: $url");
  //     var response = await client.get(Uri.http(uri, '/ass'));
  //     // var response =
  //     // await client.get(Uri.parse('http://192.168.56.1:4000/ass'));

  //     print("response ${response}");
  //     if (response.statusCode == 200) {
  //       print('Response status: ${response.statusCode}');

  //       // print('employee ${response.employee}');
  //       // print('Response body: ${response.body}');

  //       print("goinggggggg wwell");
  //     } else {
  //       print("else get details working");
  //     }
  //   } catch (error) {
  //     print("error $error");
  //   } finally {
  //     client.close();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    void logIn() {
      print("ttttt");
      print(emailController.text);
      authService.signInUser(
          email: emailController.text,
          password: passwordController.text,
          context: context);
    }

    // bool isPassword_visible = false;
    return Scaffold(
      // appBar: AppBar(title: Text("L"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text("Login"),
              const SizedBox(
                height: 100,
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.mail_outline_outlined,
                      size: 30,
                    ),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    hintText: "Password ",
                    prefixIcon: Icon(
                      IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                      size: 30,
                    ),
                    suffix: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.visibility),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: logIn,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  child: const Text("Log In"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("OR"),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  child: const Text("Sign Up"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: SignInButton(Buttons.google,
                    elevation: BorderSide.strokeAlignOutside,
                    padding: const EdgeInsets.all(2), onPressed: () {
                  authService.handleSGoogleignIn(context: context);
                },
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1.0),
                        borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: SignInButton(Buttons.facebookNew,
                    elevation: BorderSide.strokeAlignOutside,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        // side: BorderSide(width: 1.0),
                        borderRadius: BorderRadius.circular(16))),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: SignInButton(Buttons.apple,
                    elevation: BorderSide.strokeAlignOutside,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1.0),
                        borderRadius: BorderRadius.circular(16))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

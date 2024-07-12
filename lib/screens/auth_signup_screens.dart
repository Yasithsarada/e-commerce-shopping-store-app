import 'package:online_shopping_store/services/auth_services.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthService authService = AuthService();

  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void signup() {
      // print("ttttt");
      print(emailController.text);
      print(passwordController.text);
      print(usernameController.text);
      authService.signUpUser(
          email: emailController.text,
          password: passwordController.text,
          username: usernameController.text,
          context: context);
    }

    return Scaffold(
      // appBar: AppBar(title: Text("L"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
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
                controller: usernameController,
                decoration: const InputDecoration(
                    hintText: "Username ",
                    prefixIcon: Icon(
                      IconData(0xe491, fontFamily: 'MaterialIcons'),
                      size: 30,
                    )),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    hintText: "Password ",
                    prefixIcon: const Icon(
                      IconData(0xe3ae, fontFamily: 'MaterialIcons'),
                      size: 30,
                    ),
                    suffix: IconButton(
                      onPressed: signup,
                      icon: const Icon(Icons.visibility),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: signup,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  child: const Text("Sign Up"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(
                    width: 10,
                  ),
                  Text("OR"),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: SignInButton(Buttons.google,
                    elevation: BorderSide.strokeAlignOutside,
                    padding: const EdgeInsets.all(2),
                    onPressed: () {},
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

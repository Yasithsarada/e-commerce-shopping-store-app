import 'package:flutter/material.dart';
import 'package:online_shopping_store/provider/user_provider.dart';
import 'package:online_shopping_store/screens/add_product.dart';
import 'package:online_shopping_store/screens/auth_login_screen.dart';
import 'package:online_shopping_store/screens/home_screen.dart';
import 'package:online_shopping_store/services/auth_services.dart';
import 'package:provider/provider.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
  ),
  appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 30,
        color: Colors.black54,
      ),
      color: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.black87),
      centerTitle: true),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (BuildContext context) => Icon(Icons.arrow_back_ios),
  ),
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      primary: Colors.white70,
      secondary: Colors.black87),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.red,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.dark,
      primary: Colors.amber,
      secondary: Colors.white),
);
void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.isUserActive(context);
    print("authService.isUserActive(context)");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? const HomeScreen()
      //     : const LoginScreen(),
      home: HomeScreen(),
    );
  }
}

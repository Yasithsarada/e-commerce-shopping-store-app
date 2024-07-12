import 'package:flutter/material.dart';
import 'package:online_shopping_store/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CentralPage extends StatelessWidget {
  const CentralPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Text(provider.user.toJson()),
    );
  }
}

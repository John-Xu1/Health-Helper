import 'package:flutter/material.dart';
import 'package:health_helper/UI/Pages/login_screen.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
      create: (_) => User(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xffE9E9E9),
          body: LoginScreen(),
        ),
      ),
    );
  }
}

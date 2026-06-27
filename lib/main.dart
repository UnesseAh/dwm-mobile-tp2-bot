import 'package:flutter/material.dart';
import 'package:dwm_bot/pages/login.page.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal
      ),
      home: LoginPage(),
    );
  }
}

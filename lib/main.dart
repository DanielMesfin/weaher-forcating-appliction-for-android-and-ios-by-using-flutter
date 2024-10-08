import 'package:flutter/material.dart';
import 'package:cilmate_check/screens/loading_screen.dart';

void main() => runApp(
  MyApp()
  );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,

      home: LoadingScreen(),
    );
  }
}

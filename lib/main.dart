import 'package:flutter/material.dart';
import 'package:urlshortner/src/screens/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF182A50),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF182A50)),
      ),
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}


import 'package:flutter/material.dart';

import 'features/home/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

/*
* Event -> Bloc -> State
* */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.pinkAccent,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 26),
        ),
      ),
      home: const Home(),
    );
  }
}

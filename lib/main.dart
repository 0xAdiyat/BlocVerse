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
        iconTheme: const IconThemeData(color: Color(0xffE8495F)),
        cardColor: const Color(0xffFFF6F7),
        primaryColor: Colors.pinkAccent,
        appBarTheme: const AppBarTheme(
          color: Color(0xffA2C2D5),
          foregroundColor: Colors.white,
          centerTitle: false,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      home: const Home(),
    );
  }
}

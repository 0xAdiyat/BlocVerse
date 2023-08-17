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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff01D2B8)),
        useMaterial3: true,
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Color(0xff01D2B8),
          foregroundColor: Colors.white,
          centerTitle: false,
          titleTextStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      home: const Home(),
    );
  }
}

import 'package:bloc_verse/flutter_timer/timer/ui/timer_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromRGBO(109, 234, 255, 1),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.black87),
        colorScheme: const ColorScheme.light(
          secondary: Colors.black54,
        ),
      ),
      home: const TimerPage(),
    );
  }
}

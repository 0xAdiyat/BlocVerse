import 'package:flutter/material.dart';

import 'ui/counter_page.dart';

class CounterApp extends MaterialApp {
  const CounterApp({super.key})
      : super(home: const CounterPage(), debugShowCheckedModeBanner: false);
}

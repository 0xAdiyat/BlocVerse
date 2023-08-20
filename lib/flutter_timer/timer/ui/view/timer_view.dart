import 'package:bloc_verse/flutter_timer/timer/ui/view/timer_actions.dart';
import 'package:bloc_verse/flutter_timer/timer/ui/view/timer_text.dart';
import 'package:flutter/material.dart';

class TimerView extends StatelessWidget {
  const TimerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Timer'),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100.0),
            child: Center(child: TimerText()),
          ),
          TimerActions(),
        ],
      ),
    );
  }
}

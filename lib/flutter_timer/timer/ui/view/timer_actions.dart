import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/timer_bloc.dart';

class TimerActions extends StatelessWidget {
  const TimerActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, current) => prev.runtimeType != current.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  FloatingActionButton(
                      child: const Icon(CupertinoIcons.play_circle),
                      onPressed: () => context
                          .read<TimerBloc>()
                          .add(TimerStartedEvent(duration: state.duration)))
                ],
              TimerRunInProgress() => [
                  FloatingActionButton(
                    child: Icon(CupertinoIcons.pause_circle),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerPausedEvent()),
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerResetEvent()),
                  ),
                ],
              TimerRunPause() => [
                  FloatingActionButton(
                    onPressed: () =>
                        context.read<TimerBloc>().add(TimerResumedEvent()),
                    child: const Icon(CupertinoIcons.play_circle),
                  ),
                  FloatingActionButton(
                      child: Icon(Icons.replay),
                      onPressed: () =>
                          context.read<TimerBloc>().add(TimerResetEvent()))
                ],
              TimerRunComplete() => [
                  FloatingActionButton(
                      child: Icon(Icons.replay),
                      onPressed: () =>
                          context.read<TimerBloc>().add(TimerResetEvent()))
                ]
            }
          ],
        );
      },
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_verse/flutter_timer/ticker.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

/*
* TimerBloc({required Ticker ticker})
  : _ticker = ticker,
    super(const TimerInitial(_duration)) {
  // ...
}
In the first snippet, the _ticker member variable is initialized using the : _ticker = ticker, syntax within the constructor's initializer list.
*  This means that when you create an instance of TimerBloc, you provide a Ticker object as a parameter, and it is used to initialize _ticker.
* */

/*Second Code Snippet:

TimerBloc(this._ticker, {required Ticker ticker})
  : super(const TimerInitial(_duration)) {
  // ...
}
In the second snippet, the _ticker member variable is initialized as a part of the constructor's parameter list. When you create an instance of TimerBloc, you provide both _ticker and ticker as parameters. _ticker is initialized directly from the first parameter, and ticker is also required as a constructor parameter but is not used to initialize _ticker.

In summary, the key difference is in how the _ticker member variable is initialized:

In the first snippet, it's initialized using the : _ticker = ticker, syntax in the constructor's initializer list.
In the second snippet, it's initialized as a part of the constructor's parameter list using this._ticker.
Both snippets achieve the same goal of initializing _ticker, but the second snippet is more concise and directly assigns the parameter to the member variable.
*/

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(_duration)) {
    on<TimerStartedEvent>(_timerStartedEvent);
    on<_TimerTickedEvent>(_tickedEvent);
    on<TimerPausedEvent>(_timerPausedEvent);
    on<TimerResumedEvent>(_timerResumedEvent);
    on<TimerResetEvent>(_timerResetEvent);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _timerStartedEvent(
      TimerStartedEvent event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(ticks: event.duration).listen((duration) {
      add(_TimerTickedEvent(duration: duration));
    });
  }

  FutureOr<void> _timerPausedEvent(
      TimerPausedEvent event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  FutureOr<void> _timerResumedEvent(
      TimerResumedEvent event, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  FutureOr<void> _tickedEvent(
      _TimerTickedEvent event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : const TimerRunComplete());
  }

  FutureOr<void> _timerResetEvent(
      TimerResetEvent event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }
}

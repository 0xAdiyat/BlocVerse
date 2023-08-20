// Here's an example of how this code works:
//
// Suppose we call tick(ticks: 5):
//
// The stream will emit values as follows: 4, 3, 2, 1, 0.
// It emits one value every second because of the Duration(seconds: 1) interval.
// After emitting 5 values, it completes because of .take(ticks).
// So, this code generates a stream of integers with a specified time interval between emissions and a limit on the number of emissions. The values emitted are calculated based on the difference between the total number of ticks (ticks) and the index of the event (x).

/*
* The expression `ticks - x - 1` calculates the value to be emitted by each event in the stream. Let's break it down:

- `ticks`: This is a parameter that represents the total number of ticks you want in the stream. It's a constant value for the entire stream.

- `x`: This is the index of the event in the stream, starting from 0 for the first event, 1 for the second event, and so on.

- `ticks - x - 1`: This expression subtracts `x` from `ticks` and then subtracts 1 more. So, for each event, the emitted value is calculated as follows:

  - For the first event (x = 0), the emitted value is `ticks - 0 - 1`, which simplifies to `ticks - 1`.

  - For the second event (x = 1), the emitted value is `ticks - 1 - 1`, which simplifies to `ticks - 2`.

  - For the third event (x = 2), the emitted value is `ticks - 2 - 1`, which simplifies to `ticks - 3`.

  - And so on.

Here's an example:

Suppose we called `tick(ticks: 5)`:

- For the first event, the emitted value is `5 - 0 - 1`, which is 4.
- For the second event, the emitted value is `5 - 1 - 1`, which is 3.
- For the third event, the emitted value is `5 - 2 - 1`, which is 2.
- And so on, until the last event, where `x` reaches 4, and the emitted value is `5 - 4 - 1`, which is 0.

So, this calculation generates a sequence of values that counts down from `ticks - 1` to 0 as the stream emits events.*/

class Ticker {
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(const Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

import 'dart:ui';

import 'package:flutter/scheduler.dart';

class DeviceMode {
  const DeviceMode._();

  static bool isLight() =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
      Brightness.light;
}

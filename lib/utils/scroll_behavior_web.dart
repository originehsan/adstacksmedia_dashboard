import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class WebScrollBehavior extends MaterialScrollBehavior {
  const WebScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
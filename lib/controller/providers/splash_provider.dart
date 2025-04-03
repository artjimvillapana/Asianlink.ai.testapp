import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashProvider = StateNotifierProvider<SplashNotifier, bool>((ref) {
  return SplashNotifier();
});

class SplashNotifier extends StateNotifier<bool> {
  SplashNotifier() : super(false) {
    _startSplash();
  }

  void _startSplash() {
    Future.delayed(const Duration(seconds: 3), () {
      state = true; // After 3 seconds, state changes
    });
  }
}

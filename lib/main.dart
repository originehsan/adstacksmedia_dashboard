import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  // Ensures Flutter bindings are initialized before runApp
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // ProviderScope is the root of the Riverpod provider tree
    // All providers are accessible anywhere below this widget
    const ProviderScope(
      child: AdstacksApp(),
    ),
  );
}
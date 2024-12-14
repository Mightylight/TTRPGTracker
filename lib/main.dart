import 'package:fluttah/pages/home_page.dart';
import 'package:fluttah/riverpod/ability_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

@override
  Widget build(BuildContext context) {
  ref.read(abilityNotifierProvider.notifier).getSaveData();
    return MaterialApp(home: HomePage());
  }
}

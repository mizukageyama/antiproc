import 'package:flutter/material.dart';
import 'package:test/features/daily_record/presentation/pages/daily_record_page.dart';
import 'package:test/injection_container.dart' as di_container;

void main() {
  di_container.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AntiProc',
      home: DailyRecordPage(),
    );
  }
}

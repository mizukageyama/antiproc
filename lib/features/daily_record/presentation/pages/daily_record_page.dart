import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/daily_record/presentation/bloc/daily_record_bloc.dart';
import 'package:test/injection_container.dart';

class DailyRecordPage extends StatelessWidget {
  const DailyRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (_) => sl<DailyRecordBloc>(),
      child: const Column(
        children: [],
      ),
    ));
  }
}

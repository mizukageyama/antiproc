import 'package:test/features/daily_record/domain/entities/user.dart';
import 'package:test/features/task/domain/entities/task.dart';

class DailyRecord {
  final int id;
  final DateTime date;
  final List<Task> tasks;
  final bool isComplete;
  final User user;

  DailyRecord({
    required this.id,
    required this.date,
    required this.tasks,
    required this.isComplete,
    required this.user,
  });
}

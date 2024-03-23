import 'package:equatable/equatable.dart';
import 'package:test/shared/domain/entities/user.dart';
import 'package:test/features/task/domain/entities/task.dart';

class DailyRecord extends Equatable {
  final int id;
  final DateTime date;
  final List<Task> tasks;
  final bool isComplete;
  final User user;

  const DailyRecord({
    required this.id,
    required this.date,
    required this.tasks,
    required this.isComplete,
    required this.user,
  });

  @override
  List<Object?> get props => [id, date, tasks, isComplete, user];
}

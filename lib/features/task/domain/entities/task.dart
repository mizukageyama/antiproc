import 'package:equatable/equatable.dart';
import 'package:test/core/domain/entities/subcategory.dart';
import 'package:test/features/task/domain/entities/task_record.dart';

class Task extends Equatable {
  final int id;
  final String title;
  final Subcategory subcategory;
  final List<TaskRecord> taskRecords;

  const Task({
    required this.id,
    required this.title,
    required this.subcategory,
    required this.taskRecords,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subcategory,
        taskRecords,
      ];
}

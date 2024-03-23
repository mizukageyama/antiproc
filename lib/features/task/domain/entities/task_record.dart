import 'package:equatable/equatable.dart';

class TaskRecord extends Equatable {
  final int id;
  final String description;
  final DateTime timeStarted;
  final DateTime timeEnded;
  final DateTime totalTime;

  const TaskRecord({
    required this.id,
    required this.description,
    required this.timeStarted,
    required this.timeEnded,
    required this.totalTime,
  });

  @override
  List<Object?> get props => [
        id,
        description,
        timeStarted,
        timeEnded,
        totalTime,
      ];
}

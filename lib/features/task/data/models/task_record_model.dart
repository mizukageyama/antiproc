import 'package:intl/intl.dart';
import 'package:test/features/task/domain/entities/task_record.dart';

class TaskRecordModel extends TaskRecord {
  const TaskRecordModel({
    required super.id,
    required super.description,
    required super.timeStarted,
    required super.timeEnded,
    required super.totalTime,
  });

  factory TaskRecordModel.fromJson(Map<String, dynamic> json) {
    return TaskRecordModel(
      id: json['id'],
      description: json['description'],
      timeStarted: DateTime.parse(json['timeStarted']),
      timeEnded: DateTime.parse(json['timeEnded']),
      totalTime: DateTime.parse("1971-01-01 ${json['totalTime']}"),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "description": description,
      "timeStarted": DateFormat('yyyy-MM-dd HH:mm:ss').format(timeStarted),
      "timeEnded": DateFormat('yyyy-MM-dd HH:mm:ss').format(timeEnded),
      "totalTime": DateFormat('HH:mm:ss').format(totalTime),
    };
  }
}

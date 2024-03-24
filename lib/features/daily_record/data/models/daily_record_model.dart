import 'package:test/shared/data/user_model.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/task/data/models/task_model.dart';
import 'package:intl/intl.dart';

class DailyRecordModel extends DailyRecord {
  const DailyRecordModel({
    required super.id,
    required super.date,
    required super.tasks,
    required super.isComplete,
    required super.user,
  });

  factory DailyRecordModel.fromJson(Map<String, dynamic> json) {
    return DailyRecordModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      tasks: (json['tasks'])
          .map<TaskModel>((taskJson) => TaskModel.fromJson(taskJson))
          .toList(),
      isComplete: json['isComplete'],
      user: UserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": DateFormat('yyyy-MM-dd').format(date),
      "tasks": tasks.map((task) => (task as TaskModel).toJson()).toList(),
      "isComplete": isComplete,
      "user": (user as UserModel).toJson(),
    };
  }
}

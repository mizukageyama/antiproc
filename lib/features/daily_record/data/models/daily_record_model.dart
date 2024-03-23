import 'package:test/shared/data/user_model.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/task/data/models/task_model.dart';
import 'package:intl/intl.dart';

class DailyRecordModel extends DailyRecord {
  const DailyRecordModel({
    required id,
    required date,
    required tasks,
    required isComplete,
    required user,
  }) : super(
          id: id,
          date: date,
          tasks: tasks,
          isComplete: isComplete,
          user: user,
        );

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
      "tasks": tasks.map((task) => (task as TaskModel).toJson()),
      "isComplete": isComplete,
      "user": (user as UserModel).toJson(),
    };
  }
}

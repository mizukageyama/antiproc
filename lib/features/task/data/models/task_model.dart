import 'package:test/features/task/data/models/task_record_model.dart';
import 'package:test/features/task/domain/entities/task.dart';
import 'package:test/shared/data/subcategory_model.dart';

class TaskModel extends Task {
  const TaskModel({
    required id,
    required title,
    required subcategory,
    required taskRecords,
  }) : super(
          id: id,
          title: title,
          subcategory: subcategory,
          taskRecords: taskRecords,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      subcategory: SubcategoryModel.fromJson(json['subcategory']),
      taskRecords: (json['taskRecords'])
          .map<TaskRecordModel>((record) => TaskRecordModel.fromJson(record))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subcategory": (subcategory as SubcategoryModel).toJson(),
      "taskRecords": taskRecords.map(
        (record) => (record as TaskRecordModel).toJson(),
      ),
    };
  }
}

import 'package:test/features/task/domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required id,
    required title,
  }) : super(
          id: id,
          title: title,
        );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title};
  }
}

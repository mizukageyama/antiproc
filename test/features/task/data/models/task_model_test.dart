import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/features/task/data/models/task_model.dart';
import 'package:test/features/task/data/models/task_record_model.dart';
import 'package:test/features/task/domain/entities/task.dart';
import 'package:test/core/data/models/category_model.dart';
import 'package:test/core/data/models/subcategory_model.dart';
import '../../../../fixtures/_fixture_reader.dart';

void main() {
  final tTaskModel = TaskModel(
    id: 3,
    title: 'Learning NextJS',
    subcategory: const SubcategoryModel(
      id: 1,
      title: "Work/School",
      iconUrl: 'sampleurlforsubcategory.com',
      mainCategory: CategoryModel(
        id: 1,
        title: "Productive Activity",
        description: "This is for activities that achieves a certain goal.",
        iconUrl: "sampleurl.com",
      ),
    ),
    taskRecords: [
      TaskRecordModel(
        id: 1,
        description: "Setup and Installation of NextJS",
        timeStarted: DateTime.parse("2024-03-23 15:00:00"),
        timeEnded: DateTime.parse("2024-03-23 16:02:00"),
        totalTime: DateTime.parse("1971-01-01 01:02:00"),
      ),
      TaskRecordModel(
        id: 2,
        description: "",
        timeStarted: DateTime.parse("2024-03-23 16:30:00"),
        timeEnded: DateTime.parse("2024-03-23 17:00:00"),
        totalTime: DateTime.parse("1971-01-01 00:30:00"),
      ),
    ],
  );

  test('should be a subclass of Task', () {
    //Assert
    expect(tTaskModel, isA<Task>());
  });

  test('should return a Task fromJson', () {
    //Arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('task.json'));

    //Act
    final result = TaskModel.fromJson(jsonMap);

    //Assert
    expect(result, tTaskModel);
  });

  test('should return the expected json using toJson', () {
    //Act
    final expectedJson = {
      "id": 3,
      "title": "Learning NextJS",
      "subcategory": {
        "id": 1,
        "title": "Work/School",
        "iconUrl": "sampleurlforsubcategory.com",
        "mainCategory": {
          "id": 1,
          "title": "Productive Activity",
          "description": "This is for activities that achieves a certain goal.",
          "iconUrl": "sampleurl.com"
        }
      },
      "taskRecords": [
        {
          "id": 1,
          "description": "Setup and Installation of NextJS",
          "timeStarted": "2024-03-23 15:00:00",
          "timeEnded": "2024-03-23 16:02:00",
          "totalTime": "01:02:00"
        },
        {
          "id": 2,
          "description": "",
          "timeStarted": "2024-03-23 16:30:00",
          "timeEnded": "2024-03-23 17:00:00",
          "totalTime": "00:30:00"
        }
      ]
    };

    //Assert
    expect(expectedJson, tTaskModel.toJson());
  });
}

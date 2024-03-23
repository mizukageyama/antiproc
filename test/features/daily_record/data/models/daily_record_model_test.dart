import 'dart:convert';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';
import 'package:test/features/task/data/models/task_record_model.dart';
import 'package:test/shared/data/category_model.dart';
import 'package:test/shared/data/subcategory_model.dart';
import 'package:test/shared/data/user_model.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/features/task/data/models/task_model.dart';
import '../../../../fixtures/_fixture_reader.dart';

void main() {
  final tDailyRecordModel = DailyRecordModel(
    id: 1,
    date: DateTime.parse("2024-03-22"),
    tasks: [
      TaskModel(
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
      ),
    ],
    isComplete: true,
    user: const UserModel(id: 1, firstName: 'Emma', lastName: 'Watsons'),
  );

  test('should be a subclass of Daily Record entity', () async {
    // Assert
    expect(tDailyRecordModel, isA<DailyRecord>());
  });

  test('should return a valid model from json', () async {
    //Arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('daily_record.json'));

    //Act
    final result = DailyRecordModel.fromJson(jsonMap);

    //Assert
    expect(result, tDailyRecordModel);
  });

  test('should return a json map containing the proper data', () async {
    //Act
    final result = tDailyRecordModel.toJson();

    //Assert
    final Map<String, dynamic> expectedMap = {
      "id": 1,
      "date": "2024-03-22",
      "tasks": [
        {
          "id": 3,
          "title": "Learning NextJS",
          "subcategory": {
            "id": 1,
            "title": "Work/School",
            "iconUrl": "sampleurlforsubcategory.com",
            "mainCategory": {
              "id": 1,
              "title": "Productive Activity",
              "description":
                  "This is for activities that achieves a certain goal.",
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
        }
      ],
      "isComplete": true,
      "user": {"id": 1, "firstName": "Emma", "lastName": "Watsons"}
    };

    expect(result, expectedMap);
  });
}

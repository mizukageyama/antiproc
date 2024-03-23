import 'dart:convert';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';
import 'package:test/features/daily_record/data/models/user_model.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/features/task/data/models/task_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tDailyRecordModel = DailyRecordModel(
    id: 1,
    date: DateTime.parse("2024-03-22"),
    tasks: const [
      TaskModel(id: 1, title: "Work"),
      TaskModel(id: 2, title: "Cooking"),
      TaskModel(id: 3, title: "Learning NextJS")
    ],
    isComplete: true,
    user: const UserModel(id: 1, name: 'Emma Watson'),
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
        {"id": 1, "title": "Work"},
        {"id": 2, "title": "Cooking"},
        {"id": 3, "title": "Learning NextJS"}
      ],
      "isComplete": true,
      "user": {"id": 1, "name": "Emma Watson"}
    };

    expect(result, expectedMap);
  });
}

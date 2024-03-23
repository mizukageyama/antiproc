import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/features/task/data/models/task_record_model.dart';
import 'package:test/features/task/domain/entities/task_record.dart';
import '../../../../fixtures/_fixture_reader.dart';

void main() {
  final tTaskRecordModel = TaskRecordModel(
    id: 1,
    description: "sample description",
    timeStarted: DateTime.parse("2024-03-23 15:30:00"),
    timeEnded: DateTime.parse("2024-03-23 16:00:00"),
    totalTime: DateTime.parse("1971-01-01 15:30:00"),
  );

  test('should be a subclass of User', () {
    //Assert
    expect(tTaskRecordModel, isA<TaskRecord>());
  });

  test('should return a TaskRecord fromJson', () {
    //Arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('task_record.json'));

    //Act
    final result = TaskRecordModel.fromJson(jsonMap);

    //Assert
    expect(result, tTaskRecordModel);
  });

  test('should return the expected json using toJson', () {
    //Act
    final expectedJson = {
      "id": 1,
      "description": "sample description",
      "timeStarted": "2024-03-23 15:30:00",
      "timeEnded": "2024-03-23 16:00:00",
      "totalTime": "15:30:00"
    };

    //Assert
    expect(expectedJson, tTaskRecordModel.toJson());
  });
}

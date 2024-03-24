import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/core/errors/exceptions.dart';
import 'package:test/features/daily_record/data/datasources/daily_record_local_ds.dart';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';
import '../../../../fixtures/_fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late DailyRecordLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = DailyRecordLocalDataSourceImpl(mockSharedPreferences);
  });

  group('getLastDailyRecord', () {
    final tdailyRecordModel = DailyRecordModel.fromJson(jsonDecode(
      fixture('daily_record.json'),
    ));
    const String tlastDailyRecordKey = 'CACHE_DAILY_RECORD';

    test(
        'should return a DailyRecordModel from SharedPreference when there is one in the cache',
        () async {
      //Arrange
      when(() => mockSharedPreferences.getString(tlastDailyRecordKey))
          .thenReturn(fixture('daily_record.json'));

      //Act
      final result = await dataSource.getLastDailyRecord();

      //Assert
      verify(() => mockSharedPreferences.getString(tlastDailyRecordKey));
      expect(result, tdailyRecordModel);
    });

    test(
        'should throw a CacheException when there is no CACHE_DAILY_RECORD in SharedPreference',
        () async {
      //Arrange
      when(() => mockSharedPreferences.getString(tlastDailyRecordKey))
          .thenReturn(null);

      //Act
      Future<void> call() async {
        await dataSource.getLastDailyRecord();
      }

      //Assert
      expect(call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheDailyRecord', () {
    final tdailyRecordModel = DailyRecordModel.fromJson(jsonDecode(
      fixture('daily_record.json'),
    ));
    const String tlastDailyRecordKey = 'CACHE_DAILY_RECORD';

    test('should call SharedPreferences to cache the data', () async {
      //Arrange
      when(() => mockSharedPreferences.setString(
              tlastDailyRecordKey, jsonEncode(tdailyRecordModel.toJson())))
          .thenAnswer((_) async => true);

      //Act
      await dataSource.cacheDailyRecord(tdailyRecordModel);

      //Assert
      final expectedJsonString = jsonEncode(tdailyRecordModel.toJson());
      verify(() => mockSharedPreferences.setString(
          tlastDailyRecordKey, expectedJsonString));
    });
  });
}

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:test/core/errors/exceptions.dart';
import 'package:test/features/daily_record/data/datasources/daily_record_remote_ds.dart';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';
import '../../../../fixtures/_fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late DailyRecordRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = DailyRecordRemoteDataSourceImpl(mockHttpClient);
  });

  final tDate = DateTime.parse('2024-03-22');
  const tUserId = 1;
  final uri = Uri.https('api.mockfly.dev',
      '/mocks/907e7056-3d1d-4457-95ad-141a5393b904/antiproc/daily_record', {
    "date": DateFormat("yyyy-MM-dd").format(tDate),
    "userId": tUserId.toString()
  });
  final tDailyRecordModel =
      DailyRecordModel.fromJson(jsonDecode(fixture('daily_record.json')));

  void setupMockHttpSuccess200() {
    when(() => mockHttpClient
            .get(uri, headers: {'Content-Type': 'application/json'}))
        .thenAnswer(
            (_) async => http.Response(fixture('daily_record.json'), 200));
  }

  void setupMockHttpFailure404() {
    when(() => mockHttpClient
            .get(uri, headers: {'Content-Type': 'application/json'}))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('cacheDailyRecord', () {
    test('''should perform a GET request on a URL with date and userId 
    being the endpoint with application/json header''', () async {
      //Arrange
      setupMockHttpSuccess200();

      //Act
      await dataSource.getDailyRecordByDate(tDate, tUserId);

      //Assert
      verify(() => mockHttpClient
          .get(uri, headers: {'Content-Type': 'application/json'}));
    });

    test('''should return DailyRecordModel when the response 
        status code is 200 (success)''', () async {
      //Arrange
      setupMockHttpSuccess200();

      //Act
      final result = await dataSource.getDailyRecordByDate(tDate, tUserId);

      //Assert
      expect(result, tDailyRecordModel);
    });

    test('should throw ServerException when the response  code is 404 or other',
        () async {
      //Arrange
      setupMockHttpFailure404();

      //Act
      call() async {
        await dataSource.getDailyRecordByDate(tDate, tUserId);
      }

      //Assert
      expect(call(), throwsA(isA<ServerException>()));
    });
  });
}

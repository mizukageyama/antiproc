import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:test/core/errors/exceptions.dart';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';

abstract class DailyRecordRemoteDataSourceIntf {
  /// Calls the http://antiproc.com?userid={number}&date={date} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DailyRecordModel> getDailyRecordByDate(DateTime date, int userId);
}

class DailyRecordRemoteDataSource implements DailyRecordRemoteDataSourceIntf {
  final http.Client httpClient;

  DailyRecordRemoteDataSource(this.httpClient);

  @override
  Future<DailyRecordModel> getDailyRecordByDate(
    DateTime date,
    int userId,
  ) async {
    final uri = Uri.https(
      'api.mockfly.dev',
      '/mocks/907e7056-3d1d-4457-95ad-141a5393b904/antiproc/daily_record',
      {
        "date": DateFormat("yyyy-MM-dd").format(date),
        "userId": userId.toString()
      },
    );

    final jsonResponse = await httpClient
        .get(uri, headers: {'Content-Type': 'application/json'});
    if (jsonResponse.statusCode == 200) {
      return DailyRecordModel.fromJson(jsonDecode(jsonResponse.body));
    } else {
      throw ServerException();
    }
  }
}

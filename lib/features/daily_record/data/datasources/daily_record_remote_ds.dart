import 'package:test/features/daily_record/data/models/daily_record_model.dart';

abstract class DailyRecordRemoteDataSource {
  /// Calls the http://antiproc.com?userid={number}&date={date} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DailyRecordModel> getDailyRecordByDate(DateTime date);
}

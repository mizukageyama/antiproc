import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/core/errors/exceptions.dart';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';

abstract class DailyRecordLocalDataSource {
  /// Gets the cached [DailyRecord] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<DailyRecordModel> getLastDailyRecord();

  Future<void> cacheDailyRecord(DailyRecordModel dailyRecordToCache);
}

const cacheDailyRecordKey = 'CACHE_DAILY_RECORD';

class DailyRecordLocalDataSourceImpl extends DailyRecordLocalDataSource {
  final SharedPreferences sharedPreferences;

  DailyRecordLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheDailyRecord(DailyRecordModel dailyRecordToCache) async {
    sharedPreferences.setString(
      cacheDailyRecordKey,
      jsonEncode(dailyRecordToCache.toJson()),
    );
  }

  @override
  Future<DailyRecordModel> getLastDailyRecord() {
    final jsonString = sharedPreferences.getString(cacheDailyRecordKey);
    if (jsonString != null) {
      return Future.value(DailyRecordModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}

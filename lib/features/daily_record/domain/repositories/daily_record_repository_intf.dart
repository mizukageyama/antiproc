import 'package:dartz/dartz.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';

abstract class DailyRecordRepositoryIntf {
  Future<Either<FailureIntf, DailyRecord>> getDailyRecordByDate(
      DateTime date, int userId);
}

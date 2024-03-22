import 'package:dartz/dartz.dart';
import 'package:test/core/errors/failure.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';

abstract class DailyRecordRepository {
  Future<Either<Failure, DailyRecord>> getDailyRecordByDate(DateTime date);
}

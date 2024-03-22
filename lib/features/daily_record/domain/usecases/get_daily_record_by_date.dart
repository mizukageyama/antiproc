import 'package:dartz/dartz.dart';
import 'package:test/core/errors/failure.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/daily_record/domain/repositories/daily_record_repository.dart';

class GetDailyRecordByDate {
  final DailyRecordRepository repository;
  GetDailyRecordByDate(this.repository);

  Future<Either<Failure, DailyRecord>> execute(DateTime date) async {
    return await repository.getDailyRecordByDate(date);
  }
}

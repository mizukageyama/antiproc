import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test/core/errors/failure.dart';
import 'package:test/core/usecases/usecase.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/daily_record/domain/repositories/daily_record_repository.dart';

class GetDailyRecordByDate implements UseCase<DailyRecord, Params> {
  final DailyRecordRepository repository;
  GetDailyRecordByDate(this.repository);

  @override
  Future<Either<Failure, DailyRecord>> call(Params params) async {
    return await repository.getDailyRecordByDate(params.date);
  }
}

class Params extends Equatable {
  final DateTime date;

  const Params({required this.date});

  @override
  List<Object?> get props => [date];
}

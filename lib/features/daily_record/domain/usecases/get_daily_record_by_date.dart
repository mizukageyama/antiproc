import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/core/usecases/usecase_intf.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/daily_record/domain/repositories/daily_record_repository_intf.dart';

class GetDailyRecordByDate implements UseCaseIntf<DailyRecord, Params> {
  final DailyRecordRepositoryIntf repository;
  GetDailyRecordByDate(this.repository);

  @override
  Future<Either<FailureIntf, DailyRecord>> call(Params params) async {
    return await repository.getDailyRecordByDate(params.date, params.userId);
  }
}

class Params extends Equatable {
  final DateTime date;
  final int userId;

  const Params({required this.date, required this.userId});

  @override
  List<Object?> get props => [date, userId];
}

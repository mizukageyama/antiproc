import 'package:dartz/dartz.dart';
import 'package:test/core/errors/exceptions.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/core/network/network_info.dart';
import 'package:test/features/daily_record/data/datasources/daily_record_local_ds.dart';
import 'package:test/features/daily_record/data/datasources/daily_record_remote_ds.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/daily_record/domain/repositories/daily_record_repository_intf.dart';

class DailyRecordRepository implements DailyRecordRepositoryIntf {
  final DailyRecordRemoteDataSourceIntf remoteDataSource;
  final DailyRecordLocalDataSourceIntf localDataSource;
  final NetworkInfoIntf networkInfo;

  DailyRecordRepository({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<FailureIntf, DailyRecord>> getDailyRecordByDate(
      DateTime date, int userId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDailyRecord =
            await remoteDataSource.getDailyRecordByDate(date, userId);
        localDataSource.cacheDailyRecord(remoteDailyRecord);
        return Right(remoteDailyRecord);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localDailyRecord = await localDataSource.getLastDailyRecord();
        return Right(localDailyRecord);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

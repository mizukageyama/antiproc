import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/core/errors/exceptions.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/core/network/network_info.dart';
import 'package:test/features/daily_record/data/datasources/daily_record_local_ds.dart';
import 'package:test/features/daily_record/data/datasources/daily_record_remote_ds.dart';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';
import 'package:test/features/daily_record/data/repositories/daily_record_repository.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/task/data/models/task_model.dart';
import 'package:test/core/data/models/user_model.dart';

class MockDailyRecordRemoteDataSource extends Mock
    implements DailyRecordRemoteDataSourceIntf {}

class MockDailyRecordLocalDataSource extends Mock
    implements DailyRecordLocalDataSourceIntf {}

class MockNetworkInfo extends Mock implements NetworkInfoIntf {}

void main() {
  late DailyRecordRepository repository;
  late MockDailyRecordRemoteDataSource mockRemoteDataSource;
  late MockDailyRecordLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockDailyRecordRemoteDataSource();
    mockLocalDataSource = MockDailyRecordLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = DailyRecordRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tDate = DateTime.now();
  const tUserId = 1;
  final tDailyRecordModel = DailyRecordModel(
    id: 1,
    date: DateTime.parse("2024-03-22"),
    tasks: const <TaskModel>[],
    isComplete: true,
    user: const UserModel(id: 1, firstName: 'Emma', lastName: 'Watsons'),
  );
  final DailyRecord tDailyRecord = tDailyRecordModel;

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getDailyRecordByDate', () {
    test('should check if the device is online', () async {
      //Arrange
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockRemoteDataSource.getDailyRecordByDate(tDate, tUserId))
          .thenAnswer((_) async => tDailyRecordModel);
      when(() => mockLocalDataSource.cacheDailyRecord(tDailyRecordModel))
          .thenAnswer((_) => Future.value());

      //Act
      await repository.getDailyRecordByDate(tDate, tUserId);

      //Assert
      verify(() => mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        //Arrange
        when(() => mockRemoteDataSource.getDailyRecordByDate(tDate, tUserId))
            .thenAnswer((_) async => tDailyRecordModel);
        when(() => mockLocalDataSource.cacheDailyRecord(tDailyRecordModel))
            .thenAnswer((_) => Future.value());

        //Act
        final result = await repository.getDailyRecordByDate(tDate, tUserId);

        //Assert
        verify(() => mockRemoteDataSource.getDailyRecordByDate(tDate, tUserId));
        expect(result, equals(Right(tDailyRecord)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        //Arrange
        when(() => mockRemoteDataSource.getDailyRecordByDate(tDate, tUserId))
            .thenAnswer((_) async => tDailyRecordModel);
        when(() => mockLocalDataSource.cacheDailyRecord(tDailyRecordModel))
            .thenAnswer((_) => Future.value());

        //Act
        await repository.getDailyRecordByDate(tDate, tUserId);

        //Assert
        verify(() => mockRemoteDataSource.getDailyRecordByDate(tDate, tUserId));
        verify(() => mockLocalDataSource.cacheDailyRecord(tDailyRecordModel));
      });

      test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
        //Arrange
        when(() => mockRemoteDataSource.getDailyRecordByDate(tDate, tUserId))
            .thenThrow(ServerException());

        //Act
        final result = await repository.getDailyRecordByDate(tDate, tUserId);

        //Assert
        verify(() => mockRemoteDataSource.getDailyRecordByDate(tDate, tUserId));
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test(
          'should return last locally cache data when the cache data is present',
          () async {
        //Arrange
        when(() => mockLocalDataSource.getLastDailyRecord())
            .thenAnswer((_) async => tDailyRecordModel);

        //Act
        final result = await repository.getDailyRecordByDate(tDate, tUserId);

        //Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getLastDailyRecord());
        expect(result, equals(Right(tDailyRecord)));
      });

      test('should return cache failure when there is no cached data',
          () async {
        //Arrange
        when(() => mockLocalDataSource.getLastDailyRecord())
            .thenThrow(CacheException());

        //Act
        final result = await repository.getDailyRecordByDate(tDate, tUserId);

        //Assert
        verifyZeroInteractions(mockRemoteDataSource);
        verify(() => mockLocalDataSource.getLastDailyRecord());
        expect(result, equals(Left(CacheFailure())));
      });
    });
  });
}

import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/daily_record/domain/usecases/get_daily_record_by_date.dart';
import 'package:test/features/daily_record/presentation/bloc/daily_record_bloc.dart';
import '../../../../fixtures/_fixture_reader.dart';

class MockGetDailyRecordByDate extends Mock
    implements GetDailyRecordByDateUsecase {}

void main() {
  late DailyRecordBloc bloc;
  late GetDailyRecordByDateUsecase mockGetDailyRecordUseCase;

  setUp(() {
    mockGetDailyRecordUseCase = MockGetDailyRecordByDate();
    bloc =
        DailyRecordBloc(getDailyRecordByDateUsecase: mockGetDailyRecordUseCase);
  });

  const String serverFailure = 'Server Failure';
  // const String cacheFailure = 'Cache Failure';

  test('initial state should be empty', () {
    expect(bloc.state, equals(EmptyState()));
  });

  group('GetDailyRecordByDate', () {
    final tDate = DateTime.parse('2024-03-22');
    const tUserId = 1;
    final DailyRecord tDailyRecord =
        DailyRecordModel.fromJson(jsonDecode(fixture('daily_record.json')));

    test('should get data from the getDailyRecordByDate use case', () async {
      //Arrange
      when(() =>
              mockGetDailyRecordUseCase(Params(date: tDate, userId: tUserId)))
          .thenAnswer((_) async => Right(tDailyRecord));

      //Act
      bloc.add(GetDailyRecordOfTheSelectedDate(tDate, tUserId));
      await untilCalled(() =>
          mockGetDailyRecordUseCase(Params(date: tDate, userId: tUserId)));

      //Assert
      verify(() =>
          mockGetDailyRecordUseCase(Params(date: tDate, userId: tUserId)));
    });

    test('should emit [Loading, Loaded] when the data is gotten successfully',
        () async {
      //Arrange
      when(() =>
              mockGetDailyRecordUseCase(Params(date: tDate, userId: tUserId)))
          .thenAnswer((_) async => Right(tDailyRecord));

      // Assert
      final expectedStates = [
        LoadingState(),
        LoadedState(dailyRecord: tDailyRecord),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      // Act
      bloc.add(GetDailyRecordOfTheSelectedDate(tDate, tUserId));
    });

    test(
        'should emit [Loading, Error] with a proper message for the error when getting data fails',
        () async {
      //Arrange
      when(() =>
              mockGetDailyRecordUseCase(Params(date: tDate, userId: tUserId)))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Assert
      final expectedStates = [
        LoadingState(),
        ErrorState(message: serverFailure),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      // Act
      bloc.add(GetDailyRecordOfTheSelectedDate(tDate, tUserId));
    });
  });
}

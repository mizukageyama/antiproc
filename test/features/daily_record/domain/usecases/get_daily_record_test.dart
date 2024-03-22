import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/daily_record/domain/entities/user.dart';
import 'package:test/features/daily_record/domain/repositories/daily_record_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/features/daily_record/domain/usecases/get_daily_record_by_date.dart';

class MockDailyRecordRepository extends Mock implements DailyRecordRepository {}

void main() {
  late GetDailyRecordByDate usecase;
  late MockDailyRecordRepository mockDailyRecordRepository;

  setUp(() {
    mockDailyRecordRepository = MockDailyRecordRepository();
    usecase = GetDailyRecordByDate(mockDailyRecordRepository);
  });

  final tDate = DateTime.now();
  final tDailyRecord = DailyRecord(
    id: 1,
    date: DateTime.now(),
    tasks: const [],
    isComplete: true,
    user: const User(id: 1, name: 'Emma'),
  );

  test('should get the daily record by date', () async {
    //Arrange
    when(() => mockDailyRecordRepository.getDailyRecordByDate(tDate))
        .thenAnswer((_) async => Right(tDailyRecord));

    // Act: Call the method under test directly
    final result = await usecase.execute(tDate);

    // Assert: Verify the result
    expect(result, Right(tDailyRecord));
    verify(() => mockDailyRecordRepository.getDailyRecordByDate(tDate));
    verifyNoMoreInteractions(mockDailyRecordRepository);
  });
}

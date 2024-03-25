import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/features/daily_record/data/models/daily_record_model.dart';
import 'package:test/features/task/data/models/task_model.dart';
import 'package:test/features/task/data/models/task_record_model.dart';
import 'package:test/core/data/models/category_model.dart';
import 'package:test/core/data/models/subcategory_model.dart';
import 'package:test/core/data/models/user_model.dart';
import 'package:test/features/daily_record/domain/repositories/daily_record_repository_intf.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/features/daily_record/domain/usecases/get_daily_record_by_date.dart';

class MockDailyRecordRepository extends Mock
    implements DailyRecordRepositoryIntf {}

void main() {
  late GetDailyRecordByDate usecase;
  late MockDailyRecordRepository mockDailyRecordRepository;

  setUp(() {
    mockDailyRecordRepository = MockDailyRecordRepository();
    usecase = GetDailyRecordByDate(mockDailyRecordRepository);
  });

  final tDate = DateTime.now();
  const tUserId = 1;
  final tDailyRecord = DailyRecordModel(
    id: 1,
    date: DateTime.now(),
    tasks: [
      TaskModel(
        id: 3,
        title: 'Learning NextJS',
        subcategory: const SubcategoryModel(
          id: 1,
          title: "Work/School",
          iconUrl: 'sampleurlforsubcategory.com',
          mainCategory: CategoryModel(
            id: 1,
            title: "Productive Activity",
            description: "This is for activities that achieves a certain goal.",
            iconUrl: "sampleurl.com",
          ),
        ),
        taskRecords: [
          TaskRecordModel(
            id: 1,
            description: "Setup and Installation of NextJS",
            timeStarted: DateTime.parse("2024-03-23 15:00:00"),
            timeEnded: DateTime.parse("2024-03-23 16:02:00"),
            totalTime: DateTime.parse("1971-01-01 01:02:00"),
          ),
          TaskRecordModel(
            id: 2,
            description: "",
            timeStarted: DateTime.parse("2024-03-23 16:30:00"),
            timeEnded: DateTime.parse("2024-03-23 17:00:00"),
            totalTime: DateTime.parse("1971-01-01 00:30:00"),
          ),
        ],
      ),
    ],
    isComplete: true,
    user: const UserModel(id: 1, firstName: 'Emma', lastName: 'Watsons'),
  );

  test('should get the daily record by date', () async {
    //Arrange
    when(() => mockDailyRecordRepository.getDailyRecordByDate(tDate, tUserId))
        .thenAnswer((_) async => Right(tDailyRecord));

    // Act: Call the method under test directly
    final result = await usecase(Params(date: tDate, userId: tUserId));

    // Assert: Verify the result
    expect(result, Right(tDailyRecord));
    verify(
        () => mockDailyRecordRepository.getDailyRecordByDate(tDate, tUserId));
    verifyNoMoreInteractions(mockDailyRecordRepository);
  });
}

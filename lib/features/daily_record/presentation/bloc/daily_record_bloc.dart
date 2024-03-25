import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/features/daily_record/domain/entities/daily_record.dart';
import 'package:test/features/daily_record/domain/usecases/get_daily_record_by_date.dart';
part 'daily_record_event.dart';
part 'daily_record_state.dart';

const String serverFailure = 'Server Failure';
const String cacheFailure = 'Cache Failure';

class DailyRecordBloc extends Bloc<DailyRecordEvent, DailyRecordState> {
  final GetDailyRecordByDate getDailyRecordByDate;

  DailyRecordBloc({required this.getDailyRecordByDate}) : super(EmptyState()) {
    on<GetDailyRecordOfTheSelectedDate>(_getDailyRecordByDateHandler);
  }

  Future<void> _getDailyRecordByDateHandler(
      GetDailyRecordOfTheSelectedDate event,
      Emitter<DailyRecordState> emit) async {
    emit(LoadingState());

    final dailyRecordEither = await getDailyRecordByDate
        .call(Params(date: event.date, userId: event.userId));

    dailyRecordEither.fold(
      (failure) => emit(ErrorState(
        message: _stringMapFailureToMessage(failure),
      )),
      (dailyRecord) => emit(LoadedState(dailyRecord: dailyRecord)),
    );
  }

  String _stringMapFailureToMessage(FailureIntf failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailure;
      case const (CacheFailure):
        return cacheFailure;
      default:
        return 'Unexpected error';
    }
  }
}

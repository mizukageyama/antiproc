part of 'daily_record_bloc.dart';

sealed class DailyRecordEvent extends Equatable {
  const DailyRecordEvent();

  @override
  List<Object> get props => [];
}

class GetDailyRecordOfTheSelectedDate extends DailyRecordEvent {
  final DateTime date;
  final int userId;

  const GetDailyRecordOfTheSelectedDate(this.date, this.userId);
}

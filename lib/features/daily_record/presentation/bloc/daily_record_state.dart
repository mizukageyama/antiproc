part of 'daily_record_bloc.dart';

sealed class DailyRecordState extends Equatable {
  final List<dynamic> properties;
  const DailyRecordState({this.properties = const <dynamic>[]});

  @override
  List<Object> get props => [properties];
}

final class EmptyState extends DailyRecordState {}

final class InitialState extends DailyRecordState {
  final DailyRecord dailyRecord;

  InitialState({required this.dailyRecord}) : super(properties: [dailyRecord]);
}

final class LoadingState extends DailyRecordState {}

final class LoadedState extends DailyRecordState {
  final DailyRecord dailyRecord;

  LoadedState({required this.dailyRecord}) : super(properties: [dailyRecord]);
}

final class ErrorState extends DailyRecordState {
  final String message;

  ErrorState({required this.message}) : super(properties: [message]);
}

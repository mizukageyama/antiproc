import 'package:equatable/equatable.dart';

abstract class FailureIntf extends Equatable {
  final List properties;
  const FailureIntf({this.properties = const <dynamic>[]});

  @override
  List<Object?> get props => properties;
}

class ServerFailure extends FailureIntf {}

class CacheFailure extends FailureIntf {}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:test/core/errors/failures.dart';

abstract class UsecaseIntf<Type, Params> {
  Future<Either<FailureIntf, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

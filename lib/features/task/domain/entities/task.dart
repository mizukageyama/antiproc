import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final int id;
  final String title;

  const Task({required this.id, required this.title});

  @override
  List<Object?> get props => [id, title];
}

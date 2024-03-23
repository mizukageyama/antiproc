import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String title;
  final String description;
  final String iconUrl;

  const Category({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [id, title, description, iconUrl];
}

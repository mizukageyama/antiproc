import 'package:equatable/equatable.dart';
import 'package:test/core/domain/entities/category.dart';

class Subcategory extends Equatable {
  final int id;
  final String title;
  final String iconUrl;
  final Category mainCategory;

  const Subcategory({
    required this.id,
    required this.title,
    required this.iconUrl,
    required this.mainCategory,
  });

  @override
  List<Object?> get props => [id, title, iconUrl, mainCategory];
}

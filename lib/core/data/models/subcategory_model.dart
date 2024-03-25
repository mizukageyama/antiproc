import 'package:test/shared/data/category_model.dart';
import 'package:test/shared/domain/entities/subcategory.dart';

class SubcategoryModel extends Subcategory {
  const SubcategoryModel({
    required super.id,
    required super.title,
    required super.mainCategory,
    required super.iconUrl,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['id'],
      title: json['title'],
      mainCategory: CategoryModel.fromJson(json['mainCategory']),
      iconUrl: json['iconUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "mainCategory": (mainCategory as CategoryModel).toJson(),
      "iconUrl": iconUrl,
    };
  }
}

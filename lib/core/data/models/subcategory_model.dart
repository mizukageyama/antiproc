import 'package:test/core/data/models/category_model.dart';
import 'package:test/core/domain/entities/subcategory.dart';

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

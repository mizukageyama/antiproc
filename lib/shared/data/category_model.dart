import 'package:test/shared/domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required id,
    required title,
    required description,
    required iconUrl,
  }) : super(
          id: id,
          title: title,
          description: description,
          iconUrl: iconUrl,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      iconUrl: json['iconUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "iconUrl": iconUrl,
    };
  }
}

import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/shared/data/category_model.dart';
import 'package:test/shared/domain/entities/category.dart';
import '../../fixtures/_fixture_reader.dart';

void main() {
  const tCategoryModel = CategoryModel(
    id: 1,
    title: "Productive Activity",
    description:
        "This is for activities that achieves a certain goal or improvement.",
    iconUrl: "sampleurl.com",
  );

  test('should be a subclass of Category', () {
    //Assert
    expect(tCategoryModel, isA<Category>());
  });

  test('should return a Category fromJson', () {
    //Arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('category.json'));

    //Act
    final result = CategoryModel.fromJson(jsonMap);

    //Assert
    expect(result, tCategoryModel);
  });

  test('should return the expected json using toJson', () {
    //Act
    final expectedJson = {
      "id": 1,
      "title": "Productive Activity",
      "description":
          "This is for activities that achieves a certain goal or improvement.",
      "iconUrl": "sampleurl.com"
    };

    //Assert
    expect(expectedJson, tCategoryModel.toJson());
  });
}

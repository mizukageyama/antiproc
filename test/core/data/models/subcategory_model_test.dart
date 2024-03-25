import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/core/data/models/category_model.dart';
import 'package:test/core/data/models/subcategory_model.dart';
import 'package:test/core/domain/entities/subcategory.dart';
import '../../../fixtures/_fixture_reader.dart';

void main() {
  const tSubcategoryModel = SubcategoryModel(
    id: 1,
    title: "Work/School",
    iconUrl: "sampleurlforsubcategory.com",
    mainCategory: CategoryModel(
      id: 1,
      title: "Productive Activity",
      description: "This is for activities that achieves a certain goal.",
      iconUrl: "sampleurl.com",
    ),
  );

  test('should be a subclass of Subcategory', () {
    //Assert
    expect(tSubcategoryModel, isA<Subcategory>());
  });

  test('should return a Subcategory fromJson', () {
    //Arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('subcategory.json'));

    //Act
    final result = SubcategoryModel.fromJson(jsonMap);

    //Assert
    expect(result, tSubcategoryModel);
  });

  test('should return the expected json using toJson', () {
    //Act
    final expectedJson = {
      "id": 1,
      "title": "Work/School",
      "iconUrl": "sampleurlforsubcategory.com",
      "mainCategory": {
        "id": 1,
        "title": "Productive Activity",
        "description": "This is for activities that achieves a certain goal.",
        "iconUrl": "sampleurl.com"
      }
    };

    //Assert
    expect(expectedJson, tSubcategoryModel.toJson());
  });
}

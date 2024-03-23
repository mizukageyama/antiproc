import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/shared/data/user_model.dart';
import 'package:test/shared/domain/entities/user.dart';
import '../../fixtures/_fixture_reader.dart';

void main() {
  const tUserModel = UserModel(id: 1, firstName: "Emma", lastName: "Watsons");

  test('should be a subclass of User', () {
    //Assert
    expect(tUserModel, isA<User>());
  });

  test('should return a User fromJson', () {
    //Arrange
    final Map<String, dynamic> jsonMap = jsonDecode(fixture('user.json'));

    //Act
    final result = UserModel.fromJson(jsonMap);

    //Assert
    expect(result, tUserModel);
  });

  test('should return the expected json using toJson', () {
    //Act
    final expectedJson = {"id": 1, "firstName": "Emma", "lastName": "Watsons"};

    //Assert
    expect(expectedJson, tUserModel.toJson());
  });
}

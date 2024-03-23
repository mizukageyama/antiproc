import 'package:test/shared/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required id,
    required firstName,
    required lastName,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "firstName": firstName, "lastName": lastName};
  }
}

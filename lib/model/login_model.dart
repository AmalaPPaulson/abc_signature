// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

LoginModel loginFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int pk;
  String username;
  String email;
  String firstName;
  String lastName;
  int userRole;
  bool isExecutive;
  bool isActive;
  int accountId;

  LoginModel({
    required this.pk,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userRole,
    required this.isExecutive,
    required this.isActive,
    required this.accountId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    pk: json["pk"],
    username: json["username"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    userRole: json["user_role"],
    isExecutive: json["is_executive"],
    isActive: json["is_active"],
    accountId: json["account_id"],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "username": username,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "user_role": userRole,
    "is_executive": isExecutive,
    "is_active": isActive,
    "account_id": accountId,
  };
}

// To parse this JSON data, do
//
//     final userCreateModel = userCreateModelFromJson(jsonString);

import 'dart:convert';

UserCreateModel userCreateModelFromJson(String str) =>
    UserCreateModel.fromJson(json.decode(str));

String userCreateModelToJson(UserCreateModel data) =>
    json.encode(data.toJson());

class UserCreateModel {
  UserCreateModel({
    required this.id,
    required this.firebaseTokenId,
    required this.firebaseNotificationTokenId,
    required this.accountCreationMethod,
    this.name,
    this.email,
    this.googleId,
    this.facebookId,
    this.appleId,
    this.range,
    this.description,
  });

  String id;
  String firebaseTokenId;
  String firebaseNotificationTokenId;
  String accountCreationMethod;
  String? name;
  String? email;
  String? googleId;
  String? facebookId;
  String? appleId;
  List<Range>? range;
  String? description;

  factory UserCreateModel.fromJson(Map<String, dynamic> json) =>
      UserCreateModel(
        id: json["_id"],
        firebaseTokenId: json["firebase_token_id"],
        firebaseNotificationTokenId: json["firebase_notification_token_id"],
        accountCreationMethod: json["account_creation_method"],
        name: json["name"],
        email: json["email"],
        googleId: json["google_id"],
        facebookId: json["facebook_id"],
        appleId: json["apple_id"],
        range: json["range"] == null
            ? null
            : List<Range>.from(json["range"].map((x) => Range.fromJson(x))),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firebase_token_id": firebaseTokenId,
        "firebase_notification_token_id": firebaseNotificationTokenId,
        "account_creation_method": accountCreationMethod,
        "name": name,
        "email": email,
        "google_id": googleId,
        "facebook_id": facebookId,
        "apple_id": appleId,
        "range": range == null
            ? null
            : List<dynamic>.from(
                range!.map(
                  (x) {
                    return x.toJson();
                  },
                ),
              ),
        "description": description,
      };
}

class Range {
  Range({
    required this.chestMin,
    required this.chestMax,
    required this.headMin,
    required this.headMax,
    required this.id,
    required this.name,
  });

  int chestMin;
  int chestMax;
  int headMin;
  int headMax;
  String id;
  String name;

  factory Range.fromJson(Map<String, dynamic> json) => Range(
        chestMin: json["chest_min"],
        chestMax: json["chest_max"],
        headMin: json["head_min"],
        headMax: json["head_max"],
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "chest_min": chestMin,
        "chest_max": chestMax,
        "head_min": headMin,
        "head_max": headMax,
        "_id": id,
        "name": name,
      };
}

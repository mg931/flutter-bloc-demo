import 'dart:convert';

List<ApiUser> apiUserFromJson(String str) =>
    List<ApiUser>.from(json.decode(str).map((x) => ApiUser.fromJson(x)));

String apiUserToJson(List<ApiUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiUser {
  ApiUser({this.id});

  String id;

  factory ApiUser.fromJson(Map<String, dynamic> json) => ApiUser(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

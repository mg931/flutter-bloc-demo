import 'dart:convert';

class ApiUser {
  ApiUser({this.id, this.name});

  int id;
  String name;

  List<ApiUser> apiUserFromJson(String str) =>
      List<ApiUser>.from(json.decode(str).map((x) => ApiUser.fromJson(x)));

  String apiUserToJson(List<ApiUser> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  factory ApiUser.fromJson(Map<String, dynamic> json) => ApiUser(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

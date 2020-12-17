import 'dart:convert';

List<ApiUser> apiUserFromJson(String str) =>
    List<ApiUser>.from(json.decode(str).map((x) => ApiUser.fromJson(x)));

String apiUserToJson(List<ApiUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiUser {
  ApiUser({this.id, this.name, this.email});

  String id;
  String name;
  String email;

  factory ApiUser.fromJson(Map<String, dynamic> json) => ApiUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": name,
      };
}

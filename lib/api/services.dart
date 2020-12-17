import 'package:flutter_bloc_demo/model/api_user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ApiUserRepo {
  Future<List<ApiUser>> getUserList();
}

class ApiUserServices implements ApiUserRepo {
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _GET_ALBUMS = '/albums';
  @override
  Future<List<ApiUser>> getUserList() async {
    Uri uri = Uri.https(_baseUrl, _GET_ALBUMS);
    Response response = await http.get(uri);
    List<ApiUser> users = apiUserFromJson(response.body);
    return users;
  }
}

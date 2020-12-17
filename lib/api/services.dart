import 'package:flutter_bloc_demo/model/api_user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class ApiUserRepo {
  Future<List<ApiUser>> getUserList();
}

class ApiUserServices implements ApiUserRepo {
  static const _baseUrl = '5fdb819391f19e00173346a4.mockapi.io';
  static const String _GET_ALBUMS = '/api/v1/users';

  @override
  Future<List<ApiUser>> getUserList() async {
    Uri uri = Uri.https(_baseUrl, _GET_ALBUMS);
    Response response = await http.get(uri);
    List<ApiUser> users = apiUserFromJson(response.body);
    return users;
  }
}

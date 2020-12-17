import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/api/exceptions.dart';
import 'package:flutter_bloc_demo/api/services.dart';
import 'package:flutter_bloc_demo/bloc/events.dart';
import 'package:flutter_bloc_demo/bloc/states.dart';
import 'package:flutter_bloc_demo/model/api_user.dart';

class ApiUsersBloc extends Bloc<ApiUserEvents, ApiUsersState> {
  final ApiUserRepo apiUserRepo;
  List<ApiUser> apiUsers;

  ApiUsersBloc({this.apiUserRepo}) : super(ApiUsersInitState());

  @override
  Stream<ApiUsersState> mapEventToState(ApiUserEvents event) async* {
    switch (event) {
      case ApiUserEvents.fetchApiUsers:
        yield ApiUsersLoading();
        try {
          apiUsers = await apiUserRepo.getUserList();
          yield ApiUsersLoaded(apiUsers: apiUsers);
        } on SocketException {
          yield ApiUsersListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield ApiUsersListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield ApiUsersListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield ApiUsersListError(
            error: UnknownException('Unknown Error Occurred'),
          );
        }

        break;
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_demo/model/api_user.dart';

abstract class ApiUsersState extends Equatable {
  @override
  List<Object> get props => [];
}

class ApiUsersInitState extends ApiUsersState {}

class ApiUsersLoading extends ApiUsersState {}

class ApiUsersLoaded extends ApiUsersState {
  final List<ApiUser> apiUsers;
  ApiUsersLoaded({this.apiUsers});
}

class ApiUsersListError extends ApiUsersState {
  final error;
  ApiUsersListError({this.error});
}

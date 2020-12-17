import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/bloc.dart';
import 'package:flutter_bloc_demo/bloc/events.dart';
import 'package:flutter_bloc_demo/bloc/states.dart';
import 'package:flutter_bloc_demo/model/api_user.dart';

class ApiUsersScreen extends StatefulWidget {
  @override
  _ApiUsersScreenState createState() => _ApiUsersScreenState();
}

class _ApiUsersScreenState extends State<ApiUsersScreen> {
  @override
  void initState() {
    super.initState();
    _loadApiUsers();
  }

  _loadApiUsers() async {
    context.bloc<ApiUsersBloc>().add(ApiUserEvents.fetchApiUsers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Users'),
      ),
      body: Container(
        child: _body(),
      ),
    );
  }

  _body() {
    return Column(
      children: [
        BlocBuilder<ApiUsersBloc, ApiUsersState>(
            builder: (BuildContext context, ApiUsersState state) {
          if (state is ApiUsersListError) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return Text('message');
          }
          if (state is ApiUsersLoaded) {
            List<ApiUser> apiUsers = state.apiUsers;
            return Text('success');
          }
          return Text('message');
        }),
      ],
    );
  }
}

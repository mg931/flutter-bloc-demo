import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/bloc.dart';
import 'package:flutter_bloc_demo/bloc/events.dart';
import 'package:flutter_bloc_demo/bloc/states.dart';
import 'package:flutter_bloc_demo/bloc/theme_bloc.dart';
import 'package:flutter_bloc_demo/bloc/theme_events.dart';
import 'package:flutter_bloc_demo/model/api_user.dart';
import 'package:flutter_bloc_demo/settings/app_themes.dart';
import 'package:flutter_bloc_demo/settings/preferences.dart';

class ApiUsersScreen extends StatefulWidget {
  @override
  _ApiUsersScreenState createState() => _ApiUsersScreenState();
}

class _ApiUsersScreenState extends State<ApiUsersScreen> {
  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadApiUsers();
  }

  _loadApiUsers() async {
    context.bloc<ApiUsersBloc>().add(ApiUserEvents.fetchApiUsers);
  }

  _loadTheme() async {
    context.bloc<ThemeBloc>().add(ThemeEvent(appTheme: Preferences.getTheme()));
  }

  _setTheme(bool darkTheme) async {
    AppTheme selectedTheme =
    darkTheme ? AppTheme.lightTheme : AppTheme.darkTheme;
    context.bloc<ThemeBloc>().add(ThemeEvent(appTheme: selectedTheme));
    Preferences.saveTheme(selectedTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Users'),
        actions: [
          Switch(
            value: Preferences.getTheme() == AppTheme.lightTheme,
            onChanged: (val) async {
              _setTheme(val);
            },
          )
        ],
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
            return Text('failed');
          }
          if (state is ApiUsersLoaded) {
            List<ApiUser> apiUsers = state.apiUsers;
            print(apiUsers);
            return Text('success loaded');
          }
          return Text('loading');
        }),
      ],
    );
  }
}

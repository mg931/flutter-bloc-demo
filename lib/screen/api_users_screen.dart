import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/bloc/bloc.dart';
import 'package:flutter_bloc_demo/bloc/events.dart';
import 'package:flutter_bloc_demo/bloc/states.dart';
import 'package:flutter_bloc_demo/bloc/theme_bloc.dart';
import 'package:flutter_bloc_demo/bloc/theme_events.dart';
import 'package:flutter_bloc_demo/model/api_user.dart';
import 'package:flutter_bloc_demo/settings/app_themes.dart';
import 'package:flutter_bloc_demo/settings/preferences.dart';
import 'package:flutter_bloc_demo/widgets/error.dart';
import 'package:flutter_bloc_demo/widgets/list_row.dart';
import 'package:flutter_bloc_demo/widgets/loading.dart';

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
        brightness: Theme.of(context).brightness,
        title: Text(
          'Flutter Bloc Demo',
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
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
            return ErrorTxt(
              message: message,
              // onTap: _loadApiUsers(),
            );
          }
          if (state is ApiUsersLoaded) {
            List<ApiUser> apiUsers = state.apiUsers;
            return _list(apiUsers);
          }
          return Loading();
        }),
      ],
    );
  }

  Widget _list(List<ApiUser> apiUsers) {
    return Expanded(
      child: ListView.builder(
        itemCount: apiUsers.length,
        itemBuilder: (_, index) {
          ApiUser user = apiUsers[index];
          return ListRow(user: user);
        },
      ),
    );
  }
}

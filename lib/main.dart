// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_demo/api/services.dart';
import 'package:flutter_bloc_demo/bloc/bloc.dart';
import 'package:flutter_bloc_demo/screen/api_users_screen.dart';
import 'package:flutter_bloc_demo/settings/preferences.dart';

import 'bloc/theme_bloc.dart';
import 'bloc/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          return MaterialApp(
            title: 'Flutter Bloc Demo',
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            home: BlocProvider(
              create: (context) => ApiUsersBloc(apiUserRepo: ApiUserServices()),
              child: ApiUsersScreen(),
            ),
          );
        },
      ),
    );
  }
}
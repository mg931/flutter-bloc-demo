import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/model/api_user.dart';

class UserText extends StatelessWidget {
  final ApiUser user;
  UserText({
    this.user
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        user.name,
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).textTheme.bodyText1.color,
        ),
      ),
    );
  }
}

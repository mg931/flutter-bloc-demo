import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/model/api_user.dart';

class UserText extends StatelessWidget {
  final ApiUser user;
  UserText({this.user});
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Row(children: <Widget>[
      CircleAvatar(
          backgroundImage: NetworkImage('https://source.unsplash.com/random')),
      Padding(
        padding: EdgeInsets.all(16.0),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            user.name,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            user.email,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1.color,
            ),
          ),
        ],
      ),
    ]));
  }
}

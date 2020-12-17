import 'package:flutter/material.dart';
import 'package:flutter_bloc_demo/model/api_user.dart';
import 'package:flutter_bloc_demo/widgets/txt.dart';

class ListRow extends StatelessWidget {
  final ApiUser user;
  ListRow({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Txt(text: 'ID is ${user.id}'),
          Txt(text: user.name),
          Txt(text: user.name),
          Divider(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:manga_remind/remind/model/reminds-model.dart';

class RemindCard extends StatelessWidget {
  final Remind remind;
  final Function onTap;

  const RemindCard({this.remind, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(

      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
                remind.name,
                style: TextStyle(fontSize: 20)),
            Text(
              remind.episode.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

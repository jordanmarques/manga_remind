import 'package:flutter/material.dart';
import 'package:manga_remind/remind.dart';

class RemindCard extends StatefulWidget {

  final Remind remind;

  const RemindCard({this.remind});

  @override
  _RemindCardState createState() => _RemindCardState(remind);


}

class _RemindCardState extends State<RemindCard> {

  final Remind remind;

  String _name = "";
  int _episode = 0;

  onTap() {
    setState(() {
      _episode++;
    });
  }

  @override
  void initState() {
    super.initState();

    _name = this.remind.name;
    _episode = this.remind.episode;
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(
        leading: FlutterLogo(),
        title: Text('$_name - $_episode'),
        trailing: Icon(Icons.more_vert),
        onTap: onTap,
      ),
    );
  }

  _RemindCardState(this.remind);

}
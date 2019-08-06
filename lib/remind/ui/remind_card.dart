import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:manga_remind/components/bordered_text.dart';
import 'package:manga_remind/remind/model/reminds_model.dart';

class RemindCard extends StatelessWidget {
  final Remind remind;
  final Function onTap;

  const RemindCard({this.remind, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4),
        child:
            _dottedContainer(remind.name, remind.episode.toString(), context));
  }

  _dottedContainer(String name, String episode, BuildContext context) {
    return DottedBorder(
      dashPattern: [9, 5],
      padding: EdgeInsets.all(4),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
        child: ListTile(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _outlinedText(name),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8.0)),
                  child: _outlinedText(episode),
                )
              ]),
          onTap: onTap,
        ),
      ),
    );
  }

  _outlinedText(String text) {
    return BorderedText(
      strokeWidth: 1.0,
      strokeColor: Colors.black,
      child: Text(
        text,
        style:
            TextStyle(fontSize: 20, color: Colors.white, fontFamily: "Mangas"),
      ),
    );
  }
}

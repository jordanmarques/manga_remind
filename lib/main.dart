import 'package:flutter/material.dart';
import 'package:manga_remind/remind/ui/remind-card.dart';
import 'package:manga_remind/remind/model/reminds-model.dart';

import 'components/bordered-text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mangas Remind',
      theme: ThemeData(
          fontFamily: 'GochiHand',
          primarySwatch: Colors.amber,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white))),
      home: MyHomePage(title: 'Mangas Remind'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final remindsModel = RemindsModel();

  List<Remind> _reminds = [];
  String _episodeInput;
  String _nameInput;

  _handleRemindsChange() {
    setState(() {
      _reminds = remindsModel.reminds;
    });
  }

  @override
  void initState() {
    super.initState();
    _reminds = remindsModel.reminds;
    remindsModel.addListener(_handleRemindsChange);
  }

  @override
  Widget build(BuildContext context) {

    var redBorederedText = BorderedText(
      strokeWidth: 7.0,
      strokeColor: Color.fromRGBO(217, 33, 20, 1),
      child: Text(
        widget.title,
        style: TextStyle(fontSize: 30),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: redBorederedText,
      ),
      body: Center(
        child: ListView(
          children: transformRemindToRemindCards(_reminds),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Increment',
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _settingModalBottomSheet(context);
          }),
    );
  }

  List<RemindCard> transformRemindToRemindCards(List<Remind> reminds) {
    var sortedList = new List<Remind>.from(reminds)
      ..sort((a, b) => a.name.compareTo(b.name));

    return sortedList
        .map((remind) => RemindCard(
              remind: remind,
              onTap: () {
                remindsModel.incrementRemind(remind);
              },
            ))
        .toList();
  }

  void _settingModalBottomSheet(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Add Remind"),
          content: Wrap(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Name"),
                onChanged: (text) {
                  _nameInput = text;
                },
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "The number of episodes you watched"),
                onChanged: (text) {
                  _episodeInput = text;
                },
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Add"),
              onPressed: () {
                setState(() {
                  remindsModel.add(Remind(
                      episode: int.parse(_episodeInput), name: _nameInput));
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }
}

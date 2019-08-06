import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemindsModel extends ChangeNotifier {
  List<Remind> _reminds = [];
  final _prefs = SharedPreferences.getInstance();

  UnmodifiableListView<Remind> get reminds => UnmodifiableListView(_reminds);

  RemindsModel() {
    _prefs.then((prefs) {
      _reminds = _jsonToRemindList(prefs.get("reminds") ?? "[]");
      notifyListeners();
    });
  }

  void add(Remind item) {
    _persistReminds((reminds) {
      reminds.add(item);
      return reminds;
    });
  }

  void remove(Remind item) {
    _persistReminds((reminds) {
      return reminds.where((remind) => remind.name != item.name).toList();
    });
  }

  void incrementRemind(Remind remind) {
    _persistReminds((reminds) {
      var cleanList = reminds.where((r) => r.name != remind.name).toList();

      cleanList.add(remind.incrementAndGet());

      return cleanList;
    });
  }

  _persistReminds(Function actions) {
    _prefs.then((prefs) {
      List<Remind> persistedReminds = _jsonToRemindList(prefs.get("reminds") ?? "[]");
      List<Remind> modifiedReminds = actions(persistedReminds);
      prefs.setString("reminds", json.encode(modifiedReminds));
      _reminds = modifiedReminds;
      notifyListeners();
    });
  }

  List<Remind> _jsonToRemindList(String jsonString) {
    var parsed = json
        .decode(jsonString)
        .cast<Map<String, dynamic>>();
    List<Remind> persistedReminds =
        parsed.map<Remind>((json) => Remind.fromJson(json)).toList();
    return persistedReminds;
  }
}

class Remind {
  final String name;
  final int episode;

  Remind incrementAndGet() {
    return Remind(episode: this.episode + 1, name: this.name);
  }

  factory Remind.fromJson(Map<String, dynamic> json) {
    return Remind(
        name: json['name'] as String, episode: json['episode'] as int);
  }

  Map<String, dynamic> toJson() => {'name': name, 'episode': episode};

  const Remind({this.episode, this.name});
}

import 'dart:collection';

import 'package:flutter/cupertino.dart';

class RemindsModel extends ChangeNotifier {
  List<Remind> _reminds = [
    Remind(name: "One Piece", episode: 2),
    Remind(name: "Haikyu", episode: 2),
    Remind(name: "DBZ Super", episode: 2)
  ];

  UnmodifiableListView<Remind> get reminds => UnmodifiableListView(_reminds);

  void add(Remind item) {
    _reminds.add(item);
    notifyListeners();
  }

  void incrementRemind(Remind remind) {
    var cleanList = _reminds
        .where((r) => r.name != remind.name)
        .toList();

    cleanList.add(remind.incrementAndGet());

    _reminds = cleanList;

    notifyListeners();
  }
}

class Remind {
  final String name;
  final int episode;

  Remind incrementAndGet() {
    return Remind(episode: this.episode + 1, name: this.name);
  }

  const Remind({this.episode, this.name});
}

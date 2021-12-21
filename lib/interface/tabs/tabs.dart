import 'package:flutter/cupertino.dart';

class Tabs{
  final int id;
  final String title;

  const Tabs({@required this.id, @required this.title}) :
        assert(id >= 0, 'index cannot be negative'),
        assert(title != null, 'title cannot be null');
}
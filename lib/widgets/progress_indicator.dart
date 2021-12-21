import 'package:flutter/material.dart';

// https://medium.com/flutterdevs/circularprogressindicator-linearprogressindicator-in-flutter-369013366ace

class HSWidget{
HSWidget._();
static Widget circularProgressIndicator() {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.blue[50],
      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
    ),
  );
}
static Widget linearProgressIndicator() {
  return LinearProgressIndicator(
    backgroundColor: Colors.blue[50],
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
    minHeight: 20,
  );
}

}

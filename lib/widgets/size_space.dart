import 'package:flutter/cupertino.dart';

class SizeSpace extends StatelessWidget {

  final double number;

  SizeSpace({this.number});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: number,
    );
  }
}

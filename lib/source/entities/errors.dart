import 'package:equatable/equatable.dart';

class Errors extends Equatable {

  final String msg;

  Errors(this.msg);

  @override
  List<Object> get props => [msg];

}
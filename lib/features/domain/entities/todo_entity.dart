import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  const TodoEntity({this.id, this.title, this.description});
  @override
  List<Object?> get props => [title, description];
}

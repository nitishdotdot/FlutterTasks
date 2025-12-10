import 'package:clean_architecture/features/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({String? id, String? title, String? description})
    : super(id: id, title: title, description: description);
  Map<String, dynamic> toJson() {
    return ({
      if (id != null) "id": id,
      if (title != null) "title": title,
      if (description != null) "description": description,
    });
  }
}

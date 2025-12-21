import 'package:clean_architecture/features/domain/entities/todo_entity.dart';
import 'package:clean_architecture/features/domain/repositories/todo_repository.dart';

class EditTodo {
  final TodoRepository repo;
  EditTodo(this.repo);
  Future<String> call(TodoEntity todo, String id) async {
    return await repo.editTodo(todo, id);
  }
}

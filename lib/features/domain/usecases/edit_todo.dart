import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/repositories/todo_repository.dart';

class EditTodo {
  final TodoRepository repo;
  EditTodo(this.repo);
  Future<void> call(TodoEntity todo, String id) async {
    await repo.editTodo(todo, id);
  }
}

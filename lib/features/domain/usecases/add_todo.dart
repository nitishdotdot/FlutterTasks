import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repo;
  AddTodo(this.repo);
  Future<void> call(TodoEntity todo) async {
    await repo.addTodo(todo);
  }
}

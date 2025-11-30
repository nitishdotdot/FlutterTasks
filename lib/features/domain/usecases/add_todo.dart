import 'package:clean_architecture/features/domain/entities/todo_entity.dart';
import 'package:clean_architecture/features/domain/repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repo;
  AddTodo(this.repo);
  Future<String> call(TodoEntity todo) async {
    return await repo.addTodo(todo);
  }
}

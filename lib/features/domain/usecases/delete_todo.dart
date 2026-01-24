import 'package:todo/features/domain/repositories/todo_repository.dart';

class DeleteTodo {
  TodoRepository repo;
  DeleteTodo(this.repo);
  Future<void> call(String id) async {
    await repo.deleteTodo(id);
  }
}

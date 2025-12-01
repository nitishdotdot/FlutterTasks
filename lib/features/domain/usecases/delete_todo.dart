import 'package:clean_architecture/features/domain/repositories/todo_repository.dart';

class DeleteTodo {
  TodoRepository repo;
  DeleteTodo(this.repo);
  Future<String> call(String id) async {
    return await repo.deleteTodo(id);
  }
}

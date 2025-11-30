import 'package:clean_architecture/features/domain/entities/todo_entity.dart';
import 'package:clean_architecture/features/domain/repositories/todo_repository.dart';

class GetAllTodo {
  TodoRepository repo;
  GetAllTodo(this.repo);
  Future<List> call() async {
    return await repo.getAllTodo();
  }
}

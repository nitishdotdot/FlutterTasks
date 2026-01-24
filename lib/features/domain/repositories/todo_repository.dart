import 'package:todo/features/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<void> addTodo(TodoEntity todo);
  Future<List> getAllTodo();
  Future<void> deleteTodo(String id);
  Future<void> editTodo(TodoEntity todo, String id);
}

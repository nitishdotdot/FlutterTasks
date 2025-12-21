import 'package:clean_architecture/features/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<String> addTodo(TodoEntity todo);
  Future<List> getAllTodo();
  Future<String> deleteTodo(String id);
  Future<String> editTodo(TodoEntity todo, String id);
}

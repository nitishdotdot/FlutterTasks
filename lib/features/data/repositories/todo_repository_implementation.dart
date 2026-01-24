import 'package:todo/features/data/models/todo_model.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/repositories/todo_repository.dart';
import 'dart:convert';
import 'package:todo/features/data/data_source/todo_data_source.dart';

class TodoRepositoryImplementation extends TodoRepository {
  final String baseUrl = "https://api.freeapi.app/api/v1/todos/";
  final TodoDatacource todoDatacource;
  TodoRepositoryImplementation(this.todoDatacource);

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todomodel = TodoModel(
      title: todo.title,
      description: todo.description,
    );
    final body = jsonEncode(todomodel.toJson());
    await todoDatacource.addthisTodo(baseUrl, body);
  }

  @override
  Future<List> getAllTodo() async {
    final response = await todoDatacource.getthisTodo(baseUrl);
    final data = response.data;
    final x = data['data'];
    if (response.statusCode == 200 || response.statusCode == 201) {
      return x;
    } else {
      return ['Failure in Getting Todo'];
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    String baseUrl1 = '$baseUrl/$id';
    final TodoModel todoModel = TodoModel(id: id);
    final body = jsonEncode(todoModel.toJson());
    await todoDatacource.deletethisTodo(baseUrl1, body);
  }

  @override
  Future<void> editTodo(TodoEntity todo, String id) async {
    String baseUrl1 = '$baseUrl/$id';
    final todoModel = TodoModel(
      title: todo.title,
      description: todo.description,
    );
    final data = jsonEncode(todoModel.toJson());
    await todoDatacource.editthisTodo(data, baseUrl1);
  }
}

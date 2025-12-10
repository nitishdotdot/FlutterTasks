import 'package:clean_architecture/features/data/models/todo_model.dart';
import 'package:clean_architecture/features/domain/entities/todo_entity.dart';
import 'package:clean_architecture/features/domain/repositories/todo_repository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clean_architecture/features/data/data_source/todo_data_source.dart';

class TodoRepositoryImplementation extends TodoRepository {
  final String baseUrl = "https://api.freeapi.app/api/v1/todos/";
  final TodoDatacource todoDatacource;
  TodoRepositoryImplementation(this.todoDatacource);

  @override
  Future<String> addTodo(TodoEntity todo) async {
    final todomodel = TodoModel(
      title: todo.title,
      description: todo.description,
    );
    final body = jsonEncode(todomodel.toJson());
    final response = await todoDatacource.addthisTodo(baseUrl, body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Success";
    } else {
      return "Failure";
    }
  }

  @override
  Future<List> getAllTodo() async {
    final response = await todoDatacource.getthisTodo(baseUrl);
    final data = jsonDecode(response.body);
    final x = data['data'];
    if (response.statusCode == 200 || response.statusCode == 201) {
      return x;
    } else {
      return ['failure'];
    }
  }

  @override
  Future<String> deleteTodo(String id) async {
    String baseUrl1 = '$baseUrl/$id';
    final TodoModel todoModel = TodoModel(id: id);
    final body = jsonEncode(todoModel.toJson());
    final response = await todoDatacource.deletethisTodo(baseUrl1, body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Success";
    } else {
      return "Failure";
    }
  }
}

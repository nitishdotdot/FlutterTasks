import 'package:clean_architecture/features/domain/entities/todo_entity.dart';
import 'package:clean_architecture/features/domain/repositories/todo_repository.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoRepositoryImplementation extends TodoRepository {
  final String baseUrl = "https://api.freeapi.app/api/v1/todos/";

  @override
  Future<String> addTodo(TodoEntity todo) async {
    final url = Uri.parse(baseUrl);
    final body = jsonEncode({
      "title": todo.title,
      "description": todo.description,
    });
    final response = await http.post(
      url,
      body: body,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return "Success";
    } else {
      return "Failure";
    }
  }

  @override
  Future<List> getAllTodo() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    final x = data['data'];
    if (response.statusCode == 200 || response.statusCode == 201) {
      return x;
    } else {
      return ['failure'];
    }
  }
}

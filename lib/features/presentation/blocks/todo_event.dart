import 'package:flutter/material.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  AddTodoEvent({required this.title, required this.description});
}

class DeleteTodoEvent extends TodoEvent {
  String id;
  int i;
  DeleteTodoEvent({required this.id, required this.i});
}

class GetAllTodoEvent extends TodoEvent {}

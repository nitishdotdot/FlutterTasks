abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  AddTodoEvent({required this.title, required this.description});
}

class DeleteTodoEvent extends TodoEvent {
  String id;
  DeleteTodoEvent({required this.id});
}

class GetAllTodoEvent extends TodoEvent {}

class EditTodoEvent extends TodoEvent {
  final String title;
  final String description;
  String id;
  EditTodoEvent({
    required this.title,
    required this.description,
    required this.id,
  });
}

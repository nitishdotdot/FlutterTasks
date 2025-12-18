abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  List<dynamic> fetchedTodos = [];
  TodoLoaded(this.fetchedTodos);
}

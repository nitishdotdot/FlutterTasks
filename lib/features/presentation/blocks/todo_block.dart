import 'package:todo/features/data/data_source/todo_data_source.dart';
import 'package:todo/features/data/repositories/todo_repository_implementation.dart';
import 'package:todo/features/domain/usecases/edit_todo.dart';
import 'package:todo/features/domain/usecases/get_all_todo.dart ';
import 'package:todo/features/domain/usecases/add_todo.dart';
import 'package:todo/features/domain/usecases/delete_todo.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/presentation/blocks/todo_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/presentation/blocks/todo_state.dart';
import 'package:todo/injection_container.dart';

class TodoBlock extends Bloc<TodoEvent, TodoState> {
  final GetAllTodo getAllTodo;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final EditTodo editTodo;
  TodoBlock({
    required this.getAllTodo,
    required this.addTodo,
    required this.deleteTodo,
    required this.editTodo,
  }) : super(TodoInitial()) {
    on<GetAllTodoEvent>(_onGetAllTodoEvent);
    on<AddTodoEvent>(_onAddTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
    on<EditTodoEvent>(_onEditTodoEvent);
  }
  Future<void> _onGetAllTodoEvent(
    GetAllTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final getAllTodo = s1<GetAllTodo>();
    final fetchedTodos = await getAllTodo();
    emit(TodoLoaded(fetchedTodos));
  }

  Future<void> _onAddTodoEvent(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final addTodo = s1<AddTodo>();
    final todoValue = TodoEntity(
      title: event.title,
      description: event.description,
    );
    await addTodo(todoValue);
    final getAllTodo = s1<GetAllTodo>();
    final fetchedTodos = await getAllTodo();
    emit(TodoLoaded(fetchedTodos));
  }

  Future<void> _onDeleteTodoEvent(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final deleteTodo = s1<DeleteTodo>();
    await deleteTodo(event.id);
    final getAllTodo = s1<GetAllTodo>();
    final fetchedTodos = await getAllTodo();
    emit(TodoLoaded(fetchedTodos));
  }

  Future<void> _onEditTodoEvent(
    EditTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final editTodo = s1<EditTodo>();
    final todoValue = TodoEntity(
      title: event.title,
      description: event.description,
    );
    await editTodo(todoValue, event.id);
    final getAllTodo = s1<GetAllTodo>();
    final fetchedTodos = await getAllTodo();
    emit(TodoLoaded(fetchedTodos));
  }
}

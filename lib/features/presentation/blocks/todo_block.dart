import 'package:clean_architecture/features/data/data_source/todo_data_source.dart';
import 'package:clean_architecture/features/data/repositories/todo_repository_implementation.dart';
import 'package:clean_architecture/features/domain/usecases/get_all_todo.dart ';
import 'package:clean_architecture/features/domain/usecases/add_todo.dart';
import 'package:clean_architecture/features/domain/usecases/delete_todo.dart';
import 'package:clean_architecture/features/domain/entities/todo_entity.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_state.dart';
import 'package:http/http.dart' as http;

class TodoBlock extends Bloc<TodoEvent, TodoState> {
  TodoBlock() : super(TodoInitial()) {
    on<GetAllTodoEvent>(_onGetAllTodoEvent);
    on<AddTodoEvent>(_onAddTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
  }
  Future<void> _onGetAllTodoEvent(
    GetAllTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final client = http.Client();
    final TodoDatacource todoDatacource = TodoDatacource(client);
    final TodoRepositoryImplementation todoRepositoryImplementation =
        TodoRepositoryImplementation(todoDatacource);
    final GetAllTodo getAllTodo = GetAllTodo(todoRepositoryImplementation);
    final fetchedTodos = await getAllTodo();
    emit(TodoLoaded(fetchedTodos));
  }

  Future<void> _onAddTodoEvent(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final client = http.Client();
    final datasource = TodoDatacource(client);
    final TodoRepositoryImplementation todoRepositoryImplementation =
        TodoRepositoryImplementation(datasource);
    final AddTodo todoUsecase = AddTodo(todoRepositoryImplementation);
    final todoValue = TodoEntity(
      title: event.title,
      description: event.description,
    );
    final String stringResponse = await todoUsecase(todoValue);
    final GetAllTodo getAllTodo = GetAllTodo(todoRepositoryImplementation);
    final fetchedTodos = await getAllTodo();
    emit(TodoLoaded(fetchedTodos));
  }

  Future<void> _onDeleteTodoEvent(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final client = http.Client();
    final datasource = TodoDatacource(client);
    final TodoRepositoryImplementation todoRepositoryImplementation =
        TodoRepositoryImplementation(datasource);
    final DeleteTodo todoUsecase = DeleteTodo(todoRepositoryImplementation);
    final String stringReponse = await todoUsecase(event.id);
    final GetAllTodo getAllTodo = GetAllTodo(todoRepositoryImplementation);
    final fetchedTodos = await getAllTodo();
    emit(TodoLoaded(fetchedTodos));
  }
}

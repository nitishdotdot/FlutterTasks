import 'package:todo/features/data/data_source/todo_data_source.dart';
import 'package:todo/features/data/repositories/todo_repository_implementation.dart';
import 'package:todo/features/domain/repositories/todo_repository.dart';
import 'package:todo/features/domain/usecases/add_todo.dart';
import 'package:todo/features/domain/usecases/delete_todo.dart';
import 'package:todo/features/domain/usecases/edit_todo.dart';
import 'package:todo/features/domain/usecases/get_all_todo.dart%20';
import 'package:todo/features/presentation/blocks/todo_block.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final s1 = GetIt.instance;

void init() {
  s1.registerLazySingleton<http.Client>(() => http.Client());
  s1.registerLazySingleton<TodoDatacource>(
    () => TodoDatacource(s1<http.Client>()),
  );
  s1.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImplementation(s1<TodoDatacource>()),
  );
  s1.registerLazySingleton(() => GetAllTodo(s1<TodoRepository>()));
  s1.registerLazySingleton(() => AddTodo(s1<TodoRepository>()));
  s1.registerLazySingleton(() => DeleteTodo(s1<TodoRepository>()));
  s1.registerLazySingleton(() => EditTodo(s1<TodoRepository>()));
  s1.registerFactory(
    () => TodoBlock(
      getAllTodo: s1<GetAllTodo>(),
      addTodo: s1<AddTodo>(),
      deleteTodo: s1<DeleteTodo>(),
      editTodo: s1<EditTodo>(),
    ),
  );
}

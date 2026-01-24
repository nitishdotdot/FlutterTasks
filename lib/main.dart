import 'package:todo/features/presentation/blocks/theme_block.dart';
import 'package:todo/features/presentation/blocks/todo_block.dart';
import 'package:todo/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/pages/add_todo_widget.dart';
import 'package:todo/features/presentation/blocks/theme_state.dart';

void main() {
  init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBlock()),
        BlocProvider(create: (_) => s1<TodoBlock>()),
      ],
      child: BlocBuilder<ThemeBlock, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Todo',
            theme: state.isDark == true ? ThemeData.dark() : ThemeData.light(),
            home: const AddTodoWidget(),
          );
        },
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo')),
      body: Center(child: Column(children: [])),
    );
  }
}

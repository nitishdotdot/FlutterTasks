import 'package:clean_architecture/features/presentation/blocks/theme_block.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/pages/add_todo_widget.dart';
import 'package:clean_architecture/features/presentation/blocks/theme_state.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<ThemeBlock, ThemeState>(
  //     builder: (context, state) {
  //       return MaterialApp(
  //         title: 'CleanArchitecture',
  //         theme: state.isDark == true ? ThemeData.dark() : ThemeData.light(),
  //         home: MultiBlocProvider(
  //           providers: [
  //             BlocProvider(create: (_) => TodoBlock()),
  //             BlocProvider(create: (_) => ThemeBlock()),
  //           ],
  //           child: const AddTodoWidget(),
  //         ),
  //       );
  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBlock()),
        BlocProvider(create: (_) => TodoBlock()),
      ],
      child: BlocBuilder<ThemeBlock, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'CleanArchitecture',
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
      appBar: AppBar(title: Text('Clean Architecture App')),
      body: Center(child: Column(children: [])),
    );
  }
}

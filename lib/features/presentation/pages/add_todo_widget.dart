import 'package:clean_architecture/features/presentation/blocks/theme_block.dart';
import 'package:clean_architecture/features/presentation/blocks/theme_event.dart';
import 'package:clean_architecture/features/presentation/blocks/theme_state.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_block.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_event.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({super.key});

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  TextEditingController? title = TextEditingController();
  TextEditingController? description = TextEditingController();
  void resetTextcontrollerfields() {
    title?.text = '';
    description?.text = '';
  }

  @override
  @override
  Widget build(BuildContext context) {
    final todoBlock = context.read<TodoBlock>();
    final themeBlock = context.read<ThemeBlock>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => todoBlock.add(GetAllTodoEvent()),
          icon: Icon(Icons.refresh),
        ),
        actions: [
          BlocBuilder<ThemeBlock, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  themeBlock.add(ChangeTheme());
                },
                icon: Icon(Icons.dark_mode),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text('Title'),
            SizedBox(
              width: 320,
              child: TextFormField(
                controller: title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Text('Description'),
            SizedBox(height: 10),
            SizedBox(
              width: 320,
              child: TextFormField(
                controller: description,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                todoBlock.add(
                  AddTodoEvent(
                    title: title!.text,
                    description: description!.text,
                  ),
                );
                resetTextcontrollerfields();
              },
              child: Text('Add'),
            ),

            Card(
              child: BlocBuilder<TodoBlock, TodoState>(
                builder: (context, state) {
                  if (state is TodoInitial) {
                    todoBlock.add(GetAllTodoEvent());
                  } else if (state is TodoLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TodoLoaded) {
                    final x = state.fetchedTodos;
                    final todos = List<Map<String, dynamic>>.from(x);
                    return Container(
                      height: 1000,
                      child: ListView.builder(
                        itemCount: todos.length,
                        itemBuilder: (BuildContext context, int i) {
                          return ListTile(
                            leading: Text('${i + 1}'),
                            title: Text('${todos[i]['title']}'),
                            subtitle: Text('${todos[i]['description']}'),
                            trailing: IconButton(
                              onPressed: () {
                                todoBlock.add(
                                  DeleteTodoEvent(id: todos[i]['_id'], i: i),
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

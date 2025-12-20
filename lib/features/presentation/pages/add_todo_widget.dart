import 'package:clean_architecture/features/presentation/blocks/theme_block.dart';
import 'package:clean_architecture/features/presentation/blocks/theme_event.dart';
import 'package:clean_architecture/features/presentation/blocks/theme_state.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_block.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_event.dart';
import 'package:clean_architecture/features/presentation/blocks/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: Text('Add Todo', style: GoogleFonts.chewy(fontSize: 20)),
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
      body: Column(
        children: [
          SizedBox(height: 10),
          Text(
            'Title',
            style: GoogleFonts.chewy(fontSize: 20, color: Colors.deepPurple),
          ),
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
          Text(
            'Description',
            style: GoogleFonts.chewy(fontSize: 20, color: Colors.deepPurple),
          ),
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
            child: Text('Add', style: GoogleFonts.chewy(fontSize: 20)),
          ),
          Expanded(
            child: Card(
              child: BlocBuilder<TodoBlock, TodoState>(
                builder: (context, state) {
                  if (state is TodoInitial) {
                    todoBlock.add(GetAllTodoEvent());
                  } else if (state is TodoLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TodoLoaded) {
                    final x = state.fetchedTodos;
                    final todos = List<Map<String, dynamic>>.from(x);
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: todos.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          leading: Text(
                            '${i + 1}',
                            style: GoogleFonts.chewy(fontSize: 20),
                          ),
                          title: Text(
                            '${todos[i]['title']}',
                            style: GoogleFonts.chewy(
                              color: Colors.deepPurple,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            '${todos[i]['description']}',
                            style: GoogleFonts.chewy(
                              color: Colors.green,
                              fontSize: 20,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              todoBlock.add(
                                DeleteTodoEvent(id: todos[i]['_id'], i: i),
                              );
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

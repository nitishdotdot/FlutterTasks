import 'package:clean_architecture/features/data/repositories/todo_repository_implementation.dart';
import 'package:clean_architecture/features/domain/entities/todo_entity.dart';
import 'package:clean_architecture/features/domain/usecases/add_todo.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture/features/domain/usecases/get_all_todo.dart';

class AddTodoWidget extends StatefulWidget {
  const AddTodoWidget({super.key});

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {
  TextEditingController? title = TextEditingController();
  TextEditingController? description = TextEditingController();
  List x = [];

  Future<void> getTodo(BuildContext context) async {
    final TodoRepositoryImplementation repo = TodoRepositoryImplementation();
    GetAllTodo(repo);
    final data = await repo.getAllTodo();
    if (data[0] == "Failure") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(data[0])));
    } else {
      setState(() {
        x = data;
        if (x.isEmpty) {
          x = [
            {"title": "---", "description": "---"},
          ];
        }
      });
    }
  }

  Future<void> addThisTodo(BuildContext context) async {
    final TodoRepositoryImplementation repo = TodoRepositoryImplementation();
    final AddTodo todoUsecase = AddTodo(repo);
    final todoValue = TodoEntity(
      title: title!.text,
      description: description!.text,
    );
    final String stringResponse = await todoUsecase(todoValue);
    if (stringResponse == "Failure") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(stringResponse)));
    }
    getTodo(context);
  }

  @override
  void initState() {
    super.initState();
    getTodo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => getTodo(context),
          icon: Icon(Icons.refresh),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              width: 320,
              child: TextFormField(
                controller: title,
                decoration: InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 320,
              child: TextFormField(
                controller: description,
                decoration: InputDecoration(
                  labelText: 'description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addThisTodo(context);
              },
              child: Text('Add'),
            ),
            SizedBox(
              width: 320,
              child: Center(
                child: Card(
                  color: const Color.fromARGB(127, 151, 223, 211),
                  child: Column(
                    children: [
                      for (int i = 0; i < x.length; i++)
                        ListTile(
                          leading: Text('${i + 1}'),
                          title: Text(
                            x[i]['title'],
                            style: TextStyle(color: Colors.blue),
                          ),
                          subtitle: Text(
                            x[i]['description'],
                            style: TextStyle(color: Colors.purpleAccent),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/todo.dart';
import '../todo_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList(); //a var to store the items in the list
  List<dynamic> _foundToDo = [];
  final _toDoController = TextEditingController();
  final TodoService _todoService = TodoService();

  void _deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse('http://127.0.0.1:8000/api/todos/$id/'),
    );

    if (response.statusCode == 204) {
      _loadTodos();
    } else {
      throw Exception('Failed to delete todo');
    }
  }

  void _toggleTodo(int id, bool completed) async {
    final response = await http.patch(
      Uri.parse('http://127.0.0.1:8000/api/todos/$id/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'completed': completed}),
    );

    if (response.statusCode == 200) {
      _loadTodos(); // Refresh list after update
    } else {
      throw Exception('Failed to update todo');
    }
  }

  @override
  //you are fetching the data in the todoslist and assigning it to the var on initialstate

  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    try {
      final todos = await _todoService.fetchTodos();
      setState(() {
        _foundToDo = todos;
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  _addTodo() async {
    var response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/todos/'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'title': _toDoController.text, 'description': 'New Todo'}),
    );

    if (response.statusCode == 201) {
      _loadTodos(); // Reload the list after adding
    } else {
      throw Exception('Failed to add todo');
    }

    _toDoController.clear();
  }

  _updateTodoStatus(String todoId, bool isDone) async {
    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/todos/$todoId/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'is_done': isDone, // Update the 'is_done' status in the backend
      }),
    );

    if (response.statusCode == 200) {
      _loadTodos(); // Reload todos to reflect changes
    } else {
      throw Exception('Failed to update todo status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15), //creates padding around the container
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "All my To-Dos",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _foundToDo.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Checkbox(
                          value: _foundToDo[index]['isDone'] ?? false,
                          onChanged: (bool? value) {
                            setState(() {
                              _foundToDo[index]['isDone'] = value;
                            });
                            _updateTodoStatus(_foundToDo[index]['id'], value!);
                          }),
                      title: Text(_foundToDo[index]['title']),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Delete To-Do"),
                                    content: Text(
                                        "Are you sure you want to delete this item?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            _deleteTodo(
                                                _foundToDo[index]['id']);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Yes")),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("No"))
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                        hintText: 'Add a new To-Do item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Colors.blueAccent),
                    ),
                    onPressed: _addTodo,
                    child: Text(
                      "+",
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
